package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import connection.SingleConnectionBanco;
import model.Ajuste;

public class DaoEstoqueRepository {
	
	private Connection connection;
	
	public DaoEstoqueRepository() {
		connection = SingleConnectionBanco.getConnection();
	}
	
	public Ajuste gravarAjuste(Ajuste ajuste) throws Exception {
		
		String sql = "INSERT INTO public.estoque(quantidade, dataajuste, idproduto, movimentacao) "
				+ " VALUES (?, ?, ?, ?);";
		
		PreparedStatement statement = connection.prepareStatement(sql);
		
		statement.setInt(1, ajuste.getQuantidade());
		statement.setDate(2, new Date(ajuste.getDataAjuste().getTime()));
		statement.setLong(3, ajuste.getIdproduto());
		statement.setString(4, ajuste.getMovimentacao());
		
		statement.execute();
		connection.commit();
		
		return ajuste;
		
		
	}
	
	public List<Ajuste> listaDeAjustesDeProdutos() throws Exception{
		
		List<Ajuste> listaAjustes = new ArrayList<Ajuste>();
		
		String sql = "SELECT id, quantidade, dataajuste, idproduto, movimentacao "
				+ " FROM public.estoque;";
		
		PreparedStatement statement = connection.prepareStatement(sql);
		
		ResultSet resultaDaConsulta = statement.executeQuery();
		
		while (resultaDaConsulta.next()) {
			Ajuste ajuste = new Ajuste();
			
			ajuste.setId(resultaDaConsulta.getLong("id"));
			ajuste.setQuantidade(resultaDaConsulta.getInt("quantidade"));
			ajuste.setDataAjuste(resultaDaConsulta.getDate("dataajuste"));
			ajuste.setMovimentacao(resultaDaConsulta.getString("movimentacao"));
			
			listaAjustes.add(ajuste);
		}
		return listaAjustes;
		
	}

}
