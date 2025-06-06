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
     * Lấy thông tin tài khoản theo username
     * @param username Tên đăng nhập của tài khoản
     * @return Thông tin tài khoản nếu tìm thấy, 404 nếu không tìm thấy
     */
    @GetMapping("/{username}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<Account> getAccountByUsername(@PathVariable String username) {
        Account account = accountService.getAccountByUsername(username);
        return account != null ? 
            ResponseEntity.ok(account) : 
            ResponseEntity.notFound().build();
    }

    /**
     * Thay đổi mật khẩu của tài khoản
     * @param username Tên đăng nhập của tài khoản
     * @param oldPassword Mật khẩu cũ
     * @param newPassword Mật khẩu mới
     * @return 200 nếu thay đổi thành công, 400 nếu thất bại
     */
    @PutMapping("/{username}/password")
    @PreAuthorize("hasRole('ADMIN') or #username == authentication.principal.username")
    public ResponseEntity<Void> changePassword(
            @PathVariable String username,
            @RequestParam String oldPassword,
            @RequestParam String newPassword) {
        try {
            accountService.changePassword(username, oldPassword, newPassword);
            return ResponseEntity.ok().build();
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().build();
        }
    }

    /**
     * Cập nhật thông tin tài khoản
     * @param username Tên đăng nhập của tài khoản
     * @param updatedAccount Thông tin tài khoản cần cập nhật
     * @return Thông tin tài khoản sau khi cập nhật nếu thành công, 400 nếu thất bại
     */
    @PutMapping("/{username}")
    @PreAuthorize("hasRole('ADMIN') or #username == authentication.principal.username")
    public ResponseEntity<Account> updateAccount(
            @PathVariable String username,
            @RequestBody Account updatedAccount) {
        try {
            Account account = accountService.updateAccount(username, updatedAccount);
            return ResponseEntity.ok(account);
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().build();
        }
    }
} 