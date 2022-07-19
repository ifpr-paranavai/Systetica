package com.frfs.systetica.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class EmailDTO implements Serializable {

    @JsonProperty("mensagem_subject")
    private String mensagemSubject;

    @JsonProperty("mensagem_text")
    private String mensagemText;
}