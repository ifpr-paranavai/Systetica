package com.frfs.systetica.service;

import com.frfs.systetica.dto.response.ReturnData;

import java.io.IOException;

public interface FileBase64Service {
    ReturnData<String> converteFileBase64(String imagemBase64) throws IOException;
}
