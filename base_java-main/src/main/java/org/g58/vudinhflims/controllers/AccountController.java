package org.g58.vudinhflims.controllers;

import org.g58.vudinhflims.entities.Account;
import org.g58.vudinhflims.services.AccountService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

/**
 * Controller quản lý các thao tác liên quan đến tài khoản người dùng
 */
@RestController
@RequestMapping("/api/accounts")
public class AccountController {

    private final AccountService accountService;

    public AccountController(AccountService accountService) {
        this.accountService = accountService;
    }

    /**
     * Lấy thông tin tài khoản theo email
     * @param email Email của tài khoản
     * @return Thông tin tài khoản nếu tìm thấy, 404 nếu không tìm thấy
     */
    @GetMapping("/{email}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<Account> getAccountByEmail(@PathVariable String email) {
        Account account = accountService.getAccountByEmail(email);
        return account != null ? 
            ResponseEntity.ok(account) : 
            ResponseEntity.notFound().build();
    }

    /**
     * Thay đổi mật khẩu của tài khoản
     * @param email Email của tài khoản
     * @param oldPassword Mật khẩu cũ
     * @param newPassword Mật khẩu mới
     * @return 200 nếu thay đổi thành công, 400 nếu thất bại
     */
    @PutMapping("/{email}/password")
    @PreAuthorize("hasRole('ADMIN') or #email == authentication.principal.username")
    public ResponseEntity<Void> changePassword(
            @PathVariable String email,
            @RequestParam String oldPassword,
            @RequestParam String newPassword) {
        try {
            accountService.changePassword(email, oldPassword, newPassword);
            return ResponseEntity.ok().build();
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().build();
        }
    }

    /**
     * Cập nhật thông tin tài khoản
     * @param email Email của tài khoản
     * @param updatedAccount Thông tin tài khoản cần cập nhật
     * @return Thông tin tài khoản sau khi cập nhật nếu thành công, 400 nếu thất bại
     */
    @PutMapping("/{email}")
    @PreAuthorize("hasRole('ADMIN') or #email == authentication.principal.username")
    public ResponseEntity<Account> updateAccount(
            @PathVariable String email,
            @RequestBody Account updatedAccount) {
        try {
            Account account = accountService.updateAccount(email, updatedAccount);
            return ResponseEntity.ok(account);
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().build();
        }
    }
} 