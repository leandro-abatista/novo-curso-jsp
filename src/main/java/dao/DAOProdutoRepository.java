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
			
		}
		
		return produto;
	}
	
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
	
	public List<Produto> listaDeProdutosCadastrados() throws Exception{
		
		List<Produto> produtos = new ArrayList<Produto>();
		
		String sql = "SELECT id, descricao, quantidade, dataentrada, unidademedida "
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
}
