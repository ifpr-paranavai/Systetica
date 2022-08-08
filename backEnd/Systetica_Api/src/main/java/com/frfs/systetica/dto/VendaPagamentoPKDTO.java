package com.frfs.systetica.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import java.io.Serializable;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class VendaPagamentoPKDTO implements Serializable {

    @JsonProperty("venda_DTO")
    private VendaDTO vendaDTO;

    @ManyToOne
    @JoinColumn(name = "pagamento_DTO")
    private PagamentoDTO pagamentoDTO;
}