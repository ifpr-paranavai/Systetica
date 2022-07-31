package com.frfs.systetica.dto.response;

import java.time.LocalDateTime;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ReturnData<T> {
    private Boolean success;
    private String message;
    private T response;
    private String responseObjectType;
    private LocalDateTime timestamp;

    public ReturnData(Boolean success, String message, T response) {
        this.success = success;
        this.message = message;
        this.response = response;
        this.responseObjectType = response.getClass().toString();
    }

    public ReturnData(Boolean success, String message) {
        this.success = success;
        this.message = message;
    }
}

