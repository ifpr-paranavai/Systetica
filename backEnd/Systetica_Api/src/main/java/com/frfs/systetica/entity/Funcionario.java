package com.frfs.systetica.entity;

import com.sun.istack.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "funcionario")
@EqualsAndHashCode
public class Funcionario implements Serializable {
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
    private Date dataNascimento;

    @NotNull
    @Column(name = "telefone1", length = 14)
    private String telefone1;

    @Column(name = "telefone2", length = 14)
    private String telefone2;

    @NotNull
    @Column(name = "email", unique = true, length = 100)
    private String email;

    @NotNull
    @Column(name = "bairro", length = 100)
    private String bairro;

    @NotNull
    @Column(name = "endereco_rua", length = 200)
    private String enderecoRua;

    @NotNull
    @Column(name = "endereco_numero")
    private Integer enderecoNumero;

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
    private Cidade idCidade;
}
