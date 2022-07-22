package com.frfs.systetica.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.Serializable;
import java.sql.Blob;
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

    @JsonProperty("data_nascimento")
    private String dataNascimento;

    @JsonProperty("telefone1")
    private String telefone1;

    @JsonProperty("telefone2")
    private String telefone2;

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

    @JsonProperty("observacao")
    private String observacao;

    @JsonProperty("data_cadastro")
    private Date dataCadastro = new Date();

    @JsonProperty("status")
    private String status = String.valueOf('A');

    @JsonProperty("cidade")
    private CidadeDTO cidade;

    @JsonProperty("roles")
    private Collection<RoleDTO> roles;

    @JsonProperty("imagemBase64")
    private String imagemBase64;
}