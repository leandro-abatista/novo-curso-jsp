package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import connection.SingleConnectionBanco;
import model.Produto;

public class DAOProdutoRepository {

	private Connection connection;
	
	public DAOProdutoRepository() {
		connection = SingleConnectionBanco.getConnection();
	}
	
	/*
	 * MÉTODO PARA SALVAR UM NOVO REGISTRO NO BANCO DE DADOS
	 */
	public Produto gravarProduto(Produto produto) throws Exception {
		
		if (produto.isProdutoNovo()) {
			
			String sql = "INSERT INTO public.produto(descricao, quantidade, dataentrada, unidademedida) "
					+ " VALUES (?, ?, ?, ?);";
			
			PreparedStatement statement = connection.prepareStatement(sql);
			
			statement.setString(1, produto.getDescricao());
			statement.setInt(2, produto.getQuantidade());
			statement.setDate(3, produto.getDataEntrada());
			statement.setString(4, produto.getUnidadeMedida());
			
			statement.execute();
			connection.commit();
			
		} else {
			
			String sql = "UPDATE public.produto "
					+ "	SET id=?, descricao=?, quantidade=?, dataentrada=?, unidademedida=?"
					+ " WHERE id = " + produto.getId();
			
			PreparedStatement statement = connection.prepareStatement(sql);
			
			statement.setLong(1, produto.getId());
			statement.setString(2, produto.getDescricao());
			statement.setInt(3, produto.getQuantidade());
			statement.setDate(4, produto.getDataEntrada());
			statement.setString(5, produto.getUnidadeMedida());
			
			statement.executeUpdate();
			connection.commit();
			
		}
		
		return produto;
	}
	
	/*
	 * MÉTODO PARA VALIDAR SE EXISTE UM PRODUTO JÁ CADASTRADO NO BANCO DE DADOS
	 */
	public boolean validarProdutoPelaDescricao(String descricao) {
		try {
			String sql = "select count(1) > 0 AS existe from produto where upper(descricao) = upper('" + descricao
					+ "')";
			PreparedStatement statement = connection.prepareStatement(sql);
			ResultSet resultadoDaConsulta = statement.executeQuery();

			if (resultadoDaConsulta.next()) {/* o next é pra ele entrar nos resultados */
				return resultadoDaConsulta.getBoolean("existe");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return false;
	}
	
	/**
	 * MÉTODO PARA LISTAR OS PRODUTOS CADASTRADOS NO BANCO DE DADOS
	 * @return
	 * @throws Exception
	 */
	public List<Produto> listaDeProdutosCadastrados() throws Exception{
		
		List<Produto> produtos = new ArrayList<Produto>();
		
		String sql = " SELECT id, descricao, quantidade, dataentrada, unidademedida "
				+ "	FROM public.produto order by id";
		
		PreparedStatement statement = connection.prepareStatement(sql);
		
		ResultSet resultadoDaConsulta = statement.executeQuery();
		
		while (resultadoDaConsulta.next()) {
			
			Produto produto = new Produto();
			produto.setId(resultadoDaConsulta.getLong("id"));
			produto.setDescricao(resultadoDaConsulta.getString("descricao"));
			produto.setQuantidade(resultadoDaConsulta.getInt("quantidade"));
			produto.setDataEntrada(resultadoDaConsulta.getDate("dataentrada"));
			produto.setUnidadeMedida(resultadoDaConsulta.getString("unidademedida"));
			
			//adciona um produto na lista a cada consulta
			produtos.add(produto);
		}
		
		//retorna a lista de produtos cadastrados
		return produtos;
		
	}
	
	/**
	 * Método para deletar um produto pelo id
	 * @param id
	 * @throws Exception
	 */
	public void deletarProduto(Long id) throws Exception {
		
		String sql = "DELETE FROM public.produto WHERE id = " + id;
		
		PreparedStatement statement = connection.prepareStatement(sql);
		
		statement.executeUpdate();
		connection.commit();
	}
	
	/**
	 * Método para consultar um produto pelo id
	 * @param idProduto
	 * @return
	 * @throws Exception
	 */
	public Produto consultarProdutoPorId(Long idProduto) throws Exception {
		
		Produto produto = new Produto();
		
		String sql = "SELECT * FROM produto WHERE id = ?";
		
		PreparedStatement statement = connection.prepareStatement(sql);
		statement.setLong(1, idProduto); 
		
		ResultSet resultaDaConsulta = statement.executeQuery();
		
		while (resultaDaConsulta.next()) {
			
			produto.setId(resultaDaConsulta.getLong("id"));
			produto.setDescricao(resultaDaConsulta.getString("descricao"));
			produto.setQuantidade(resultaDaConsulta.getInt("quantidade"));
			produto.setDataEntrada(resultaDaConsulta.getDate("dataentrada"));
			produto.setUnidadeMedida(resultaDaConsulta.getString("unidademedida"));
			
		}
		
		return produto;
	}
	
	/**
	 * Método para consultar um produto pela descrição
	 * @param descricaoProduto
	 * @return
	 * @throws Exception
	 */
	public Produto consultarProdutoPorDescricao(String descricaoProduto) throws Exception {
		
		Produto produto = new Produto();
		
		String sql = "SELECT * FROM produto WHERE descricao = ?";
		
		PreparedStatement statement = connection.prepareStatement(sql);
		statement.setString(1, descricaoProduto); 
		
		ResultSet resultaDaConsulta = statement.executeQuery();
		
		while (resultaDaConsulta.next()) {
			
			produto.setId(resultaDaConsulta.getLong("id"));
			produto.setDescricao(resultaDaConsulta.getString("descricao"));
			produto.setQuantidade(resultaDaConsulta.getInt("quantidade"));
			produto.setDataEntrada(resultaDaConsulta.getDate("dataentrada"));
			produto.setUnidadeMedida(resultaDaConsulta.getString("unidademedida"));
			
		}
		
		return produto;
		
	}
	
	public List<Produto> consultarListaDeProdutosPorDescricao(String descricaoProduto) throws Exception {
		
		List<Produto> listaDeProdutos = new ArrayList<Produto>();
		String sql = "SELECT * FROM produto WHERE UPPER(descricao) LIKE UPPER('%" + descricaoProduto + "%')"
				+ " ORDER BY id";
		
		PreparedStatement statement = connection.prepareStatement(sql);
		
		ResultSet resultaDaConsulta = statement.executeQuery();
		
		while (resultaDaConsulta.next()) {
			Produto produto = new Produto();
			
			produto.setId(resultaDaConsulta.getLong("id"));
			produto.setDescricao(resultaDaConsulta.getString("descricao"));
			produto.setQuantidade(resultaDaConsulta.getInt("quantidade"));
			produto.setDataEntrada(resultaDaConsulta.getDate("dataentrada"));
			produto.setUnidadeMedida(resultaDaConsulta.getString("unidademedida"));
			
			listaDeProdutos.add(produto);
		}
		
		return listaDeProdutos;
	}
	
	public Produto adicionarEstoque(Long id, int quantidadeAjustada) throws Exception {
		
		
		if (id != null) {
			
			String sql = "UPDATE public.produto "
					+ " SET quantidade = quantidade + " + quantidadeAjustada + " WHERE id = " + id;
			
			PreparedStatement statement = connection.prepareStatement(sql);
			
			statement.executeUpdate();
			connection.commit();
			
		}
		
		return null;
		
	}
}
