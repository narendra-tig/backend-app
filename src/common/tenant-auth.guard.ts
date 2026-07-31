import {
  CanActivate,
  ExecutionContext,
  ForbiddenException,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { timingSafeEqual } from 'node:crypto';
import type { Request } from 'express';
import { verify, type JwtPayload } from 'jsonwebtoken';

interface Open360JwtPayload extends JwtPayload {
  context?: {
    tenantId?: string;
    applicationContext?: Array<{
      applicationName?: string;
      refId?: string;
    }>;
    user?: { id?: string };
  };
}

@Injectable()
export class TenantAuthGuard implements CanActivate {
  canActivate(context: ExecutionContext): boolean {
    const request = context.switchToHttp().getRequest<Request>();
    if (this.hasInternalKey(request)) return true;

    const tenantId = request.header('x-tenant-id');
    if (!tenantId) throw new UnauthorizedException('x-tenant-id is required');
    const token = this.getToken(request);
    if (!token) throw new UnauthorizedException('Authorization is required');

    const secret = process.env.TOKEN_JWT_SECRET;
    if (!secret) {
      throw new UnauthorizedException('TOKEN_JWT_SECRET is not configured');
    }
    let payload: Open360JwtPayload;
    try {
      payload = verify(token, secret, {
        algorithms: ['HS256'],
        audience: process.env.TOKEN_JWT_AUDIENCE || undefined,
      }) as Open360JwtPayload;
    } catch {
      throw new UnauthorizedException('Invalid or expired authorization token');
    }
    if (payload.context?.tenantId !== tenantId) {
      throw new ForbiddenException('Token tenant does not match x-tenant-id');
    }
    const targetAccountId =
      request.params?.accountId ?? request.header('x-account-id');
    if (targetAccountId) {
      const hasAccountAccess = payload.context.applicationContext?.some(
        (item) =>
          item.applicationName === 'ACCOUNT_APP' &&
          item.refId === targetAccountId,
      );
      if (!hasAccountAccess) {
        throw new ForbiddenException('Token does not grant account access');
      }
    }
    return true;
  }

  private getToken(request: Request): string | undefined {
    const authorization = request.header('authorization');
    if (authorization?.startsWith('Bearer ')) {
      return authorization.slice('Bearer '.length);
    }
    const cookieName =
      process.env.ENV === 'prod' ? 'auth' : `auth_${process.env.ENV}`;
    return request.cookies?.[cookieName] as string | undefined;
  }

  private hasInternalKey(request: Request): boolean {
    const expected = process.env.INTERNAL_API_KEY;
    const received = request.header('x-internal-api-key');
    if (!expected || !received) return false;
    const left = Buffer.from(expected);
    const right = Buffer.from(received);
    return left.length === right.length && timingSafeEqual(left, right);
  }
}
