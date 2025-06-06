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
            Role adminRole = Role.builder()
                    .name("ROLE_ADMIN")
                    .createdAt(LocalDateTime.now())
                    .createdBy("SYSTEM")
                    .build();
            Role userRole = Role.builder()
                    .name("ROLE_USER")
                    .createdAt(LocalDateTime.now())
                    .createdBy("SYSTEM")
                    .build();
            roleRepository.save(adminRole);
            roleRepository.save(userRole);
        }

        if (accountRepository.count() == 0) {
            Role adminRole = roleRepository.findByName("ROLE_ADMIN").orElseThrow();
            Role userRole = roleRepository.findByName("ROLE_USER").orElseThrow();

            // Create admin account
            Account adminAccount = Account.builder()
                    .username("admin")
                    .password(passwordEncoder.encode("admin123"))
                    .createdAt(LocalDateTime.now())
                    .createdBy("SYSTEM")
                    .build();
            accountRepository.save(adminAccount);

            // Add roles to admin account
            RoleAccount adminRoleAccount = RoleAccount.builder()
                    .accountID(adminAccount.getAccountID())
                    .roleID(adminRole.getRoleID())
                    .account(adminAccount)
                    .role(adminRole)
                    .createdAt(LocalDateTime.now())
                    .createdBy("SYSTEM")
                    .build();
            adminAccount.getRoles().add(adminRoleAccount);

            RoleAccount userRoleAccount = RoleAccount.builder()
                    .accountID(adminAccount.getAccountID())
                    .roleID(userRole.getRoleID())
                    .account(adminAccount)
                    .role(userRole)
                    .createdAt(LocalDateTime.now())
                    .createdBy("SYSTEM")
                    .build();
            adminAccount.getRoles().add(userRoleAccount);
            accountRepository.save(adminAccount);

            // Create normal user account
            Account normalAccount = Account.builder()
                    .username("user")
                    .password(passwordEncoder.encode("user123"))
                    .createdAt(LocalDateTime.now())
                    .createdBy("SYSTEM")
                    .build();
            accountRepository.save(normalAccount);

            // Add role to normal user account
            RoleAccount normalUserRoleAccount = RoleAccount.builder()
                    .accountID(normalAccount.getAccountID())
                    .roleID(userRole.getRoleID())
                    .account(normalAccount)
                    .role(userRole)
                    .createdAt(LocalDateTime.now())
                    .createdBy("SYSTEM")
                    .build();
            normalAccount.getRoles().add(normalUserRoleAccount);
            accountRepository.save(normalAccount);
        }
    }
}
