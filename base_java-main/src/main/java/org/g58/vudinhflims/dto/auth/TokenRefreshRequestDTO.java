package org.g58.vudinhflims.dto.auth;

import lombok.Data;

@Data
public class TokenRefreshRequestDTO {
    private String refreshToken;
}
