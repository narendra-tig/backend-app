import { Controller } from '@nestjs/common';
import { TypedBody, TypedRoute } from '@nestia/core';
import type {
  CreateTrackingEnquiryRequest,
  CreateTrackingEnquiryResponse,
  EnquiryType,
} from '../contracts';
import { EnquiriesService } from './enquiries.service';

@Controller('v1/tracking/enquiries')
export class EnquiriesController {
  constructor(private readonly enquiries: EnquiriesService) {}

  @TypedRoute.Get('types')
  getTypes(): EnquiryType[] {
    return this.enquiries.getTypes();
  }

  @TypedRoute.Post()
  create(
    @TypedBody() input: CreateTrackingEnquiryRequest,
  ): Promise<CreateTrackingEnquiryResponse> {
    return this.enquiries.create(input);
  }
}
