package com.frfs.systetica.service;

import com.frfs.systetica.dto.response.ReturnData;
import org.apache.commons.lang3.RandomStringUtils;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

import java.io.IOException;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
@ActiveProfiles(profiles = "local")
@AutoConfigureMockMvc
@DisplayName("FileBase64ServiceTest")
public class FileBase64ServiceTest {

    @Autowired
    private FileBase64ServiceImpl fileBase64Service;

    @Test
    @DisplayName("Deve converter imagem em base 64")
    public void deveConverteFileBase64() throws IOException {
        String imagemBase64 = "imagembase64paratestedemetodo";

        fileBase64Service.converteFileBase64(imagemBase64);
    }

    @Test
    @DisplayName("Deve informar que imagem deve possuir menos de 10mb")
    public void deveInformarImagemDeveSerMenorDezMb() throws IOException {
        String imagemBase64 = RandomStringUtils.randomAscii(11485760);

        ReturnData<String> returnData = new ReturnData<>(false, "Imagem deve possuir menos de 10mb.");

        assertEquals(fileBase64Service.converteFileBase64(imagemBase64), returnData);
    }
}
