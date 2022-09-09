package com.frfs.systetica.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateSerializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalTimeSerializer;
import com.sun.istack.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import java.time.LocalTime;
import java.util.Date;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class EmpresaDTO {

    @JsonProperty("id")
    private Long id;

    @JsonProperty("nome")
    private String nome;

    @JsonProperty("cnpj")
    private String cnpj;

    @JsonProperty("telefone1")
    private String telefone1;

    @JsonProperty("telefone2")
    private String telefone2;

    @JsonProperty("endereco")
    private String endereco;

    @JsonProperty("numero")
    private int numero;

    @JsonProperty("cep")
    private String cep;

    @JsonProperty("bairro")
    private String bairro;

    @JsonProperty("latitude")
    private String latitude;

    @JsonProperty("longitude")
    private String longitude;

    @JsonProperty("logo_base64")
    private String logoBase64;

    @JsonProperty("data_cadastro")
    private Date dataCadastro;

    @JsonProperty("status")
    private Boolean status;

    @JsonProperty("cidade")
    private CidadeDTO cidade;

    @JsonProperty("usuario_administrador")
    private UsuarioDTO usuarioAdministrador;

    @JsonProperty("nome_usuario")
    private String nomeUsuario;

    @JsonProperty("usuarios")
    private List<UsuarioDTO> usuarios;

    @JsonProperty("horario_abertura")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "HH:mm")
    private LocalTime horarioAbertura;

    @JsonProperty("horario_fechamento")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "HH:mm")
    private LocalTime horarioFechamento;
}
