import { Controller } from '@nestjs/common';
import { TypedBody, TypedHeaders, TypedParam, TypedRoute } from '@nestia/core';
import type {
  BookReturnRequest,
  ReturnShipmentView,
  ReturnTokenHeaders,
  Uuid,
  ValidateReturnRequest,
  ValidateReturnResponse,
} from '../contracts';
import { ReturnsService } from './returns.service';

@Controller('v1/tracking/returns')
export class ReturnsController {
  constructor(private readonly returns: ReturnsService) {}

  @TypedRoute.Get(':returnCode')
  findByCode(
    @TypedHeaders() headers: ReturnTokenHeaders,
    @TypedParam('returnCode') returnCode: string,
  ): Promise<ReturnShipmentView> {
    return this.returns.findByCode(returnCode, headers['x-return-token']);
  }

  @TypedRoute.Post('validate')
  validate(
    @TypedBody() input: ValidateReturnRequest,
  ): Promise<ValidateReturnResponse> {
    return this.returns.validate(input);
  }

  @TypedRoute.Post(':shipmentId/book')
  book(
    @TypedHeaders() headers: ReturnTokenHeaders,
    @TypedParam('shipmentId') shipmentId: Uuid,
    @TypedBody() input: BookReturnRequest,
  ): Promise<ReturnShipmentView> {
    return this.returns.book(shipmentId, headers['x-return-token'], input);
  }
}
