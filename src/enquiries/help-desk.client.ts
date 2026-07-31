import { Injectable, OnModuleDestroy } from '@nestjs/common';
import {
  credentials,
  type Client,
  type ClientUnaryCall,
  loadPackageDefinition,
  type ChannelCredentials,
  type ServiceError,
} from '@grpc/grpc-js';
import { loadSync } from '@grpc/proto-loader';
import { join } from 'node:path';
import { readFileSync } from 'node:fs';

export interface HelpDeskCreateEnquiryRequest {
  description: string;
  subject: string;
  email: string;
  status: 'OPEN' | 'CLOSED';
  type: string;
  priority: 'LOW' | 'MEDIUM' | 'HIGH' | 'URGENT';
  attachments: [];
  organisationalUnitId: string;
  freightDescription: string;
  valueOfFreight?: string;
  receiverContactName?: string;
  receiverContactDetails?: string;
  name: string;
  jobTitle?: string;
  shipmentId: string;
  internalReference?: string;
  isLiveChat?: boolean;
  billingCode: number;
  isNeedOfData?: boolean;
  accountBillingCode?: number;
  phone?: string;
  shipmentReference?: string;
  receiverName?: string;
  source?: string;
}

interface HelpDeskCreateEnquiryResponse {
  id: string;
}

interface EnquiriesGrpcClient extends Client {
  createEnquiry(
    request: HelpDeskCreateEnquiryRequest,
    callback: (
      error: ServiceError | null,
      response: HelpDeskCreateEnquiryResponse,
    ) => void,
  ): ClientUnaryCall;
}

type EnquiriesGrpcConstructor = new (
  address: string,
  channelCredentials: ChannelCredentials,
) => EnquiriesGrpcClient;

@Injectable()
export class HelpDeskClient implements OnModuleDestroy {
  private client?: EnquiriesGrpcClient;

  async createEnquiry(input: HelpDeskCreateEnquiryRequest): Promise<string> {
    const client = this.getClient();
    return new Promise<string>((resolve, reject) => {
      client.createEnquiry(input, (error, response) => {
        if (error) {
          reject(error);
          return;
        }
        resolve(response.id);
      });
    });
  }

  onModuleDestroy(): void {
    this.client?.close();
  }

  private getClient(): EnquiriesGrpcClient {
    if (this.client) return this.client;
    const address = process.env.HELP_DESK_SERVICE_URL;
    if (!address) {
      throw new Error('HELP_DESK_SERVICE_URL is not defined');
    }
    const definition = loadSync(join(__dirname, 'proto/enquiries.proto'), {
      keepCase: false,
      longs: String,
      enums: String,
      defaults: true,
      oneofs: true,
    });
    const grpcPackage = loadPackageDefinition(definition) as unknown as {
      help_desk: { EnquiriesService: EnquiriesGrpcConstructor };
    };
    this.client = new grpcPackage.help_desk.EnquiriesService(
      address,
      this.getCredentials(),
    );
    return this.client;
  }

  private getCredentials(): ChannelCredentials {
    if (process.env.HELP_DESK_GRPC_INSECURE === 'true') {
      if (process.env.ENV !== 'local' && process.env.NODE_ENV !== 'test') {
        throw new Error('Insecure help-desk gRPC is allowed only locally');
      }
      return credentials.createInsecure();
    }
    const caPath = process.env.HELP_DESK_GRPC_CA_PATH;
    if (!caPath) {
      throw new Error('HELP_DESK_GRPC_CA_PATH is not configured');
    }
    return credentials.createSsl(readFileSync(caPath));
  }
}
