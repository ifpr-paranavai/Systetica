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
    @Column(name = "cpf", unique = true, length = 14)
    private String cpf;

    @NotNull
    @Column(name = "data_nascimento")
    private String dataNascimento;

    @NotNull
    @Column(name = "telefone1", length = 15)
    private String telefone1;

    @Column(name = "telefone2", length = 15)
    private String telefone2;

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

    @Column(name = "observacao", length = 300)
    private String observacao;

    @NotNull
    @Column(name = "data_cadastro")
    private Date dataCadastro;

    @NotNull
    @Column(name = "status", length = 1)
    private String status = String.valueOf('A');

    @NotNull
    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_cidade")
    private Cidade cidade;

    @ManyToMany(fetch = FetchType.EAGER)
    private Collection<Role> roles = new ArrayList<>();;
}
