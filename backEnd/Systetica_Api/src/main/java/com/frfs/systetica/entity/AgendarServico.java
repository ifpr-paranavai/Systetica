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
@Table(name = "agendar_servico")
@EqualsAndHashCode
public class AgendarServico implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    @Column(name = "nome", length = 100)
    private String nome;

    @NotNull
    @Column(name = "data_agendamento_servico")
    private Date dataAgendamentoServico;

    @NotNull
    @Column(name = "data_finalizacao_servico")
    private Date dataFinalizacaoServico;

    @NotNull
    @Column(name = "data_cadastro_servico")
    private Date dataCadastroServico;

    @Column(name = "situacao", length = 300)
    private String situacao;

    @Column(name = "observacao", length = 300)
    private String observacao;

    @NotNull
    @Column(name = "status", length = 1)
    private String status = String.valueOf('A');

    @Column(name = "nome_cliente", length = 300)
    private String nomeCliente;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_cliente")
    private Usuario idUsuario;

    @NotNull
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_funcionario")
    private Funcionario idFuncionario;

//    @ManyToMany(cascade = [CascadeType.MERGE])
    @ManyToMany(cascade = CascadeType.ALL)
    @JoinTable(
            name = "ass_servico_agendado",
            uniqueConstraints = @UniqueConstraint(columnNames = {"id_agendar_servico", "id_servico"}),
            joinColumns = @JoinColumn(name = "id_agendar_servico"),
            inverseJoinColumns = @JoinColumn(name = "id_servico"))
    private List<Servico> servicos = new ArrayList<>();

}