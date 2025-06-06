package org.g58.vudinhflims.services;

import org.g58.vudinhflims.entities.Token;
import org.g58.vudinhflims.entities.Account;
import org.g58.vudinhflims.repositories.TokenRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class TokenService {

    private final TokenRepository tokenRepository;

    public TokenService(TokenRepository tokenRepository) {
        this.tokenRepository = tokenRepository;
    }

    public void saveToken(Token token) {
        tokenRepository.save(token);
    }

    public Optional<Token> findByToken(String token) {
        return tokenRepository.findByToken(token);
    }

    public void revokeToken(Token token) {
        token.setRevoked(true);
        tokenRepository.save(token);
    }

    public void deleteExpiredTokens() {
    }

    @Transactional
    public void revokeAllUserTokens(Account account) {
        List<Token> validUserTokens = tokenRepository.findAllValidTokenByUser(account.getAccountID());
        if (validUserTokens.isEmpty()) return;
        
        validUserTokens.forEach(token -> {
            token.setRevoked(true);
        });
        tokenRepository.saveAll(validUserTokens);
    }
}