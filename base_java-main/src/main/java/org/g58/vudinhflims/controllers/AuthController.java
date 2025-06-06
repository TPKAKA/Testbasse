package org.g58.vudinhflims.controllers;

import org.g58.vudinhflims.dto.base.APIResponse;
import org.g58.vudinhflims.dto.auth.LoginRequestDTO;
import org.g58.vudinhflims.dto.auth.TokenRefreshRequestDTO;
import org.g58.vudinhflims.dto.auth.TokenResponseDTO;
import org.g58.vudinhflims.services.AuthService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    private final AuthService authService;

    public AuthController(AuthService authService) {
        this.authService = authService;
    }

    @PostMapping("/login")
    public ResponseEntity<APIResponse<TokenResponseDTO>> login(@RequestBody LoginRequestDTO request) {
        TokenResponseDTO tokenResponse = authService.login(request.getUsername(), request.getPassword());
        return ResponseEntity.ok(APIResponse.success("Login successful", tokenResponse));
    }

    @PostMapping("/refresh-token")
    public ResponseEntity<APIResponse<TokenResponseDTO>> refreshToken(@RequestBody TokenRefreshRequestDTO request) {
        TokenResponseDTO tokenResponse = authService.refreshToken(request.getRefreshToken());
        return ResponseEntity.ok(APIResponse.success("Token refreshed", tokenResponse));
    }
}
