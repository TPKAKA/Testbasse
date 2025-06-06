package org.g58.vudinhflims.repositories;

import org.g58.vudinhflims.entities.Token;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface TokenRepository extends JpaRepository<Token, Long> {
    Optional<Token> findByToken(String token);

    @Query("SELECT t FROM Token t WHERE t.account.accountID = :userId AND t.revoked = false")
    List<Token> findAllValidTokenByUser(Long userId);
}
