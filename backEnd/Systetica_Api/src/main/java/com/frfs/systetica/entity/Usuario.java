package com.frfs.systetica.entity;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.sun.istack.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "usuario")
@EqualsAndHashCode
public class Usuario implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    @Column(name = "nome", length = 100)
    private String nome;

    @NotNull
    @Column(name = "telefone", length = 15)
    private String telefone;

    @NotNull
    @Column(name = "email", unique = true, length = 100)
    private String email;

    @JsonProperty(value = "password", access = JsonProperty.Access.WRITE_ONLY)
    @Column(name = "password", nullable = false, length = 100)
    private String password;

    @NotNull
    @Column(name = "codigo_aleatorio")
    private Integer codigoAleatorio;

    @Column(name = "data_codigo")
    private Date dataCodigo;

    @Column(name = "usuario_ativo")
    private Boolean usuarioAtivo;

    @NotNull
    @Column(name = "data_cadastro")
    private Date dataCadastro;

    @ManyToMany(fetch = FetchType.EAGER)
    private Collection<Role> roles = new ArrayList<>();

    @Lob
    @Column(name = "imagem_base64", length = 16777215)
    private String imagemBase64;

    @Column(name = "permissao_funcionario")
    private Boolean permissaoFuncionario;

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
            name = "ass_funcionario_empresa",
            uniqueConstraints = @UniqueConstraint(columnNames = {"id_usuario", "id_empresa"}),
            joinColumns = @JoinColumn(name = "id_usuario"),
            inverseJoinColumns = @JoinColumn(name = "id_empresa"))
    private List<Empresa> empresas = new ArrayList<>();

    public List<Empresa> getEmpresas() {
        return null;
    }
}
