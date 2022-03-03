package model;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Objects;

public class Ajuste implements Serializable {

	private static final long serialVersionUID = 1L;

	private Long id;
	private Integer quantidade;
	private Date dataAjuste = new Date();
	private List<Produto> produtos = new ArrayList<Produto>();
	private String movimentacao;
	private Long idproduto;

	public Ajuste() {
	}
	
	

	public Ajuste(Long id, Integer quantidade, Date dataAjuste, List<Produto> produtos, String movimentacao,
			Long idproduto) {
		super();
		this.id = id;
		this.quantidade = quantidade;
		this.dataAjuste = dataAjuste;
		this.produtos = produtos;
		this.movimentacao = movimentacao;
		this.idproduto = idproduto;
	}



	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Integer getQuantidade() {
		return quantidade;
	}

	public void setQuantidade(Integer quantidade) {
		this.quantidade = quantidade;
	}

	public Date getDataAjuste() {
		return dataAjuste;
	}

	public void setDataAjuste(Date dataAjuste) {
		this.dataAjuste = dataAjuste;
	}

	public List<Produto> getProdutos() {
		return produtos;
	}

	public String getMovimentacao() {
		return movimentacao;
	}

	public void setMovimentacao(String movimentacao) {
		this.movimentacao = movimentacao;
	}

	public Long getIdproduto() {
		return idproduto;
	}

	public void setIdproduto(Long idproduto) {
		this.idproduto = idproduto;
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Ajuste other = (Ajuste) obj;
		return Objects.equals(id, other.id);
	}

}
