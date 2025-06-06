package org.g58.vudinhflims.dto.user;

import lombok.Data;
import java.util.List;

@Data
public class UserProfileDTO {
    private String username;
    private List<String> roles;
}
