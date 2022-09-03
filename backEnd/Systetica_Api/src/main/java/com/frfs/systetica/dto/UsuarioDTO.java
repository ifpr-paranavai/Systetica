package com.frfs.systetica.dto;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import java.io.Serializable;
import java.util.Collection;
import java.util.Date;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class UsuarioDTO implements Serializable {

    @JsonProperty("id")
    private Long id;

    @JsonProperty("nome")
    private String nome;

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
    private Date dataCadastro;

    @JsonProperty("roles")
    private Collection<RoleDTO> roles;

    @JsonProperty("imagem_base64")
    private String imagemBase64;

    @JsonIgnore
    @JsonProperty("empresas")
    private List<EmpresaDTO> empresas;

    @JsonProperty("permissao_funcionario")
    private Boolean permissaoFuncionario;

    @JsonProperty("email_administrativo")
    private String emailAdministrativo;
}