package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;

import connection.SingleConnectionBanco;
import model.Produto;

public class DAOProdutoRepository {

	private Connection connection;
	
	public DAOProdutoRepository() {
		connection = SingleConnectionBanco.getConnection();
	}
	
	public Produto gravarProduto(Produto produto) throws Exception {
		
		String sql = "INSERT INTO public.produto(descricao, quantidade, dataentrada) VALUES (?, ?, ?);";
		
		PreparedStatement statement = connection.prepareStatement(sql);
		
		statement.setString(1, produto.getDescricao());
		statement.setInt(2, produto.getQuantidade());
		statement.setDate(3, produto.getDataEntrada());
		
		statement.execute();
		connection.commit();
		
		return produto;
	}
}
