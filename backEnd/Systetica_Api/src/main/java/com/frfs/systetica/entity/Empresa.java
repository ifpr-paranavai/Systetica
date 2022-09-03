package com.frfs.systetica.entity;

import com.sun.istack.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "empresa")
public class Empresa implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    @Column(name = "nome", length = 150)
    private String nome;

    @NotNull
    @Column(name = "cnpj", length = 18, unique = true)
    private String cnpj;

    @NotNull
    @Column(name = "telefone1", length = 15)
    private String telefone1;

    @Column(name = "telefone2", length = 15)
    private String telefone2;

    @NotNull
    @Column(name = "endereco", length = 100)
    private String endereco;

    @NotNull
    @Column(name = "numero", length = 8)
    private int numero;

    @NotNull
    @Column(name = "cep", length = 9)
    private String cep;

    @NotNull
    @Column(name = "bairro", length = 100)
    private String bairro;

    @Column(name = "latitude", length = 13)
    private String latitude;

    @Column(name = "longitude", length = 13)
    private String longitude;

    @Column(name = "logo_base64")
    @Lob
    private String logoBase64;

    @NotNull
    @Column(name = "data_cadastro")
    private Date dataCadastro;

    @NotNull
    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_cidade")
    private Cidade cidade;

    @NotNull
    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_usuario_administrador")
    private Usuario usuarioAdministrador;

    @ManyToMany()
    @JoinTable(
            name = "ass_funcionario_empresa",
            uniqueConstraints = @UniqueConstraint(columnNames = {"id_empresa", "id_usuario"}),
            joinColumns = @JoinColumn(name = "id_empresa"),
            inverseJoinColumns = @JoinColumn(name = "id_usuario"))
    private List<Usuario> usuarios = new ArrayList<>();
}