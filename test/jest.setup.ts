import { doNotThrowTransformError } from '@nestia/core';

// Jest uses ts-jest rather than Nestia's ttsc compiler. Runtime validation is
// covered by the transformed production build and generated SDK contract.
doNotThrowTransformError(false);
