import { IsEnum, IsOptional, IsString, IsUUID } from 'class-validator';
import { AccountGrade, AccountStanding } from '../../../models/accounts/enums';

export class CreateAccountDto {
  @IsString()
  name!: string;

  @IsUUID()
  tenantId!: string;

  @IsString()
  displayName!: string;

  @IsOptional()
  @IsString()
  ofTenancy?: string;

  @IsOptional()
  @IsEnum(AccountStanding)
  standing?: AccountStanding;

  @IsOptional()
  @IsEnum(AccountGrade)
  grade?: AccountGrade;
}
