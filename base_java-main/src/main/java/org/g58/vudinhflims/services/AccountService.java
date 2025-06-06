package org.g58.vudinhflims.services;

import jakarta.transaction.Transactional;
import org.g58.vudinhflims.entities.Account;
import org.g58.vudinhflims.repositories.AccountRepository;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Transactional
public class AccountService {

    private final AccountRepository accountRepository;
    private final PasswordEncoder passwordEncoder;

    public AccountService(AccountRepository accountRepository,
                         PasswordEncoder passwordEncoder) {
        this.accountRepository = accountRepository;
        this.passwordEncoder = passwordEncoder;
    }

    public Account getAccountByUsername(String username) {
        return accountRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("Account not found"));
    }

    public void changePassword(String username, String oldPassword, String newPassword) {
        Account account = getAccountByUsername(username);
        
        if (!passwordEncoder.matches(oldPassword, account.getPassword())) {
            throw new RuntimeException("Current password is incorrect");
        }
        
        account.setPassword(passwordEncoder.encode(newPassword));
        accountRepository.save(account);
    }

    public Account updateAccount(String username, Account updatedAccount) {
        Account existingAccount = getAccountByUsername(username);
        
        existingAccount.setFullName(updatedAccount.getFullName());
        existingAccount.setEmail(updatedAccount.getEmail());
        existingAccount.setPhone(updatedAccount.getPhone());
        
        return accountRepository.save(existingAccount);
    }

    public List<Account> getAllAccounts() {
        return accountRepository.findAll();
    }

    public Account createAccount(Account account) {
        if (accountRepository.existsByUsername(account.getUsername())) {
            throw new RuntimeException("Username already exists");
        }
        
        account.setPassword(passwordEncoder.encode(account.getPassword()));
        return accountRepository.save(account);
    }

    public void deleteAccount(Long id) {
        accountRepository.deleteById(id);
    }

    public Account getAccountById(Long id) {
        return accountRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Account not found"));
    }
} 