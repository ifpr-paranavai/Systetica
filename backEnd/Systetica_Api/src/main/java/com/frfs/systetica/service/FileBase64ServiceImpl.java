package com.frfs.systetica.service;

import com.frfs.systetica.dto.response.ReturnData;
import com.frfs.systetica.utils.Constantes;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.tomcat.util.codec.binary.Base64;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class FileBase64ServiceImpl implements FileBase64Service {

    @Override //TODO - criar um service específico
    public ReturnData<String> converteFileBase64(String imagemBase64) {

        byte[] bytesEncoded = Base64.encodeBase64(imagemBase64.getBytes());

        if (bytesEncoded.length > Constantes.FILE_DEZ_MB) {
            return new ReturnData<>(false, "Imagem deve possuir menos de 10mb.");
        }

        return new ReturnData<>(true, imagemBase64);
    }
}
