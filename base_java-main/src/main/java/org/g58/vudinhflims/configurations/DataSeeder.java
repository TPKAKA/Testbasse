package org.g58.vudinhflims.configurations;

import jakarta.transaction.Transactional;
import org.g58.vudinhflims.entities.Role;
import org.g58.vudinhflims.entities.Account;
import org.g58.vudinhflims.entities.RoleAccount;
import org.g58.vudinhflims.repositories.RoleRepository;
import org.g58.vudinhflims.repositories.AccountRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.time.LocalDateTime;

@Configuration
public class DataSeeder implements CommandLineRunner {

    private final RoleRepository roleRepository;
    private final AccountRepository accountRepository;
    private final PasswordEncoder passwordEncoder;

    public DataSeeder(RoleRepository roleRepository, AccountRepository accountRepository, PasswordEncoder passwordEncoder) {
        this.roleRepository = roleRepository;
        this.accountRepository = accountRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    @Transactional
    public void run(String... args) throws Exception {
        if (roleRepository.count() == 0) {
            Role adminRole = new Role();
            adminRole.setName("ROLE_ADMIN");
            adminRole.setCreatedAt(LocalDateTime.now());
            roleRepository.save(adminRole);

            Role userRole = new Role();
            userRole.setName("ROLE_USER");
            userRole.setCreatedAt(LocalDateTime.now());
            roleRepository.save(userRole);
        }

        if (accountRepository.count() == 0) {
            Role adminRole = roleRepository.findByName("ROLE_ADMIN").orElseThrow();
            Role userRole = roleRepository.findByName("ROLE_USER").orElseThrow();

            // Create admin account
            Account adminAccount = new Account();
            adminAccount.setEmail("admin@example.com");
            adminAccount.setPassword(passwordEncoder.encode("admin123"));
            adminAccount.setStatus(true);
            adminAccount.setCreatedAt(LocalDateTime.now());
            accountRepository.save(adminAccount);

            // Add roles to admin account
            RoleAccount adminRoleAccount = new RoleAccount();
            adminRoleAccount.setAccount(adminAccount);
            adminRoleAccount.setRole(adminRole);
            adminRoleAccount.setCreatedAt(LocalDateTime.now());
            adminAccount.getRoles().add(adminRoleAccount);

            RoleAccount userRoleAccount = new RoleAccount();
            userRoleAccount.setAccount(adminAccount);
            userRoleAccount.setRole(userRole);
            userRoleAccount.setCreatedAt(LocalDateTime.now());
            adminAccount.getRoles().add(userRoleAccount);
            accountRepository.save(adminAccount);

            // Create normal user account
            Account normalAccount = new Account();
            normalAccount.setEmail("user@example.com");
            normalAccount.setPassword(passwordEncoder.encode("user123"));
            normalAccount.setStatus(true);
            normalAccount.setCreatedAt(LocalDateTime.now());
            accountRepository.save(normalAccount);

            // Add role to normal user account
            RoleAccount normalUserRoleAccount = new RoleAccount();
            normalUserRoleAccount.setAccount(normalAccount);
            normalUserRoleAccount.setRole(userRole);
            normalUserRoleAccount.setCreatedAt(LocalDateTime.now());
            normalAccount.getRoles().add(normalUserRoleAccount);
            accountRepository.save(normalAccount);
        }
    }
}
