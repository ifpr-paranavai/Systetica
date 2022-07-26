package com.frfs.systetica.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Collection;
import java.util.Date;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL) // todo adicionar em outros DTOS
public class UsuarioDTO implements Serializable {

    @JsonProperty("id")
    private Long id;

    @JsonProperty("nome")
    private String nome;

    @JsonProperty("cpf")
    private String cpf;

    @JsonProperty("telefone")
    private String telefone;

    @JsonProperty("email")
    private String email;

    @JsonProperty("password")
    private String password;

    @JsonProperty("codigo_aleatorio")
    private Integer codigoAleatorio;

    @JsonProperty("data_codigo")
    private Date dataCodigo;

    @JsonProperty("usuario_ativo")
    private Boolean usuarioAtivo = false;

    @JsonProperty("data_cadastro")
    private Date dataCadastro = new Date();

    @JsonProperty("status")
    private String status = String.valueOf('A');

    @JsonProperty("roles")
    private Collection<RoleDTO> roles;

    @JsonProperty("imagemBase64")
    private String imagemBase64;
}