package org.g58.vudinhflims.configurations;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Data
@Component
@ConfigurationProperties(prefix = "spring.security.jwt")
public class JwtConfig {
    private String secret;
    private long expiration;
    private long refreshExpiration;
}
