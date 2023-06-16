import { applyDecorators } from '@nestjs/common';
import {
    Doc,
    DocAuth,
    DocResponse,
} from 'src/common/doc/decorators/doc.decorator';

export function UserUserDeleteSelfDoc(): MethodDecorator {
    return applyDecorators(
        Doc({
            operation: 'modules.user.user',
        }),
        DocAuth({
            jwtAccessToken: true,
        }),
        DocResponse('user.deleteSelf')
    );
}