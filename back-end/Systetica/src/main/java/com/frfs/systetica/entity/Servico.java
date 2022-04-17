package com.frfs.systetica.entity;

import com.sun.istack.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
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
@Table(name = "servico")
@EqualsAndHashCode
public class Servico implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    @Column(name = "nome", length = 100)
    private String nome;

    @NotNull
    @Column(name = "tempo_servico")
    private Integer tempoServico;

    @NotNull
    @Column(name = "tipo_servico", length = 80)
    private String tipoServico;

    @NotNull
    @Column(name = "descricao", length = 250)
    private String descricao;

    @NotNull
    @Column(name = "preco")
    private Double preco;

    @NotNull
    @Column(name = "data_cadastro")
    private Date dataCadastro;

    @NotNull
    @Column(name = "status", length = 1)
    private String status = String.valueOf('A');

    @ManyToMany(cascade = CascadeType.ALL)
    @JoinTable(
            name = "ass_servico_agendado",
            uniqueConstraints = @UniqueConstraint(columnNames = {"id_servico", "id_agendar_servico"}),
            joinColumns = @JoinColumn(name = "id_servico"),
            inverseJoinColumns = @JoinColumn(name = "id_agendar_servico"))
    private List<AgendarServico> agendarServicos = new ArrayList<>();

}