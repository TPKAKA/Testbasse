package org.g58.vudinhflims.services;

import org.g58.vudinhflims.configurations.JwtConfig;
import org.g58.vudinhflims.dto.auth.TokenResponseDTO;
import org.g58.vudinhflims.entities.Token;
import org.g58.vudinhflims.entities.Account;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@Service
public class AuthService {

    private final AuthenticationManager authenticationManager;
    private final AccountService accountService;
    private final JwtService jwtService;
    private final PasswordEncoder passwordEncoder;
    private final TokenService tokenService;
    private final JwtConfig jwtConfig;

    public AuthService(AuthenticationManager authenticationManager,
                       AccountService accountService,
                       JwtService jwtService,
                       PasswordEncoder passwordEncoder,
                       TokenService tokenService,
                       JwtConfig jwtConfig) {
        this.authenticationManager = authenticationManager;
        this.accountService = accountService;
        this.jwtService = jwtService;
        this.passwordEncoder = passwordEncoder;
        this.tokenService = tokenService;
        this.jwtConfig = jwtConfig;
    }

    @Transactional
    public TokenResponseDTO login(String email, String password) {
        Account account = accountService.getAccountByEmail(email);
        if (account == null) {
            throw new RuntimeException("Account not found");
        }

        try {
            authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(email, password));
        } catch (BadCredentialsException ex) {
            throw new RuntimeException("Invalid email or password");
        }

        // Revoke all existing tokens for this account
        tokenService.revokeAllUserTokens(account);

        String accessToken = jwtService.generateAccessToken(email);
        String refreshToken = jwtService.generateRefreshToken(email);

        long refreshSeconds = jwtConfig.getRefreshExpiration() / 1000;

        Token token = Token.builder()
                .token(refreshToken)
                .tokenType("REFRESH")
                .revoked(false)
                .expiryDate(LocalDateTime.now().plusSeconds(refreshSeconds))
                .account(account)
                .build();

        tokenService.saveToken(token);

        return new TokenResponseDTO(accessToken, refreshToken);
    }

    @Transactional
    public TokenResponseDTO refreshToken(String refreshToken) {
        if (!jwtService.validateToken(refreshToken)) {
            throw new RuntimeException("Invalid refresh token");
        }

        String username = jwtService.extractUsername(refreshToken);
        var tokenOptional = tokenService.findByToken(refreshToken);

        if (tokenOptional.isEmpty() || 
            tokenOptional.get().isRevoked() || 
            !tokenOptional.get().getTokenType().equals("REFRESH") ||
            jwtService.isTokenExpired(refreshToken)) {
            throw new RuntimeException("Invalid or expired refresh token");
        }

        String newAccessToken = jwtService.generateAccessToken(username);
        return new TokenResponseDTO(newAccessToken, refreshToken);
    }

    @Transactional
    public void logout(String refreshToken) {
        var tokenOptional = tokenService.findByToken(refreshToken);
        if (tokenOptional.isPresent()) {
            Token token = tokenOptional.get();
            token.setRevoked(true);
            tokenService.saveToken(token);
        }
    }
}
