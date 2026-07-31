import {
  CanActivate,
  ExecutionContext,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { timingSafeEqual } from 'node:crypto';
import type { Request } from 'express';

@Injectable()
export class InternalApiGuard implements CanActivate {
  canActivate(context: ExecutionContext): boolean {
    const expected = process.env.INTERNAL_API_KEY;
    if (!expected) {
      throw new UnauthorizedException('INTERNAL_API_KEY is not configured');
    }
    const request = context.switchToHttp().getRequest<Request>();
    const received = request.header('x-internal-api-key');
    if (!received || !this.equals(expected, received)) {
      throw new UnauthorizedException('Invalid internal API key');
    }
    return true;
  }

  private equals(expected: string, received: string): boolean {
    const left = Buffer.from(expected);
    const right = Buffer.from(received);
    return left.length === right.length && timingSafeEqual(left, right);
  }
}
