package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import connection.SingleConnectionBanco;
import model.ModelLogin;

public class DAOUsuarioRepository {

	private Connection connection;

	public DAOUsuarioRepository() {
		connection = SingleConnectionBanco.getConnection();
	}

	public ModelLogin gravarUsuario(ModelLogin modelLogin) throws Exception{
			
			if (modelLogin.isNovo()) {/*grava um novo*/
				
			String sql = "INSERT INTO model_login(login, senha, nome, email) VALUES (?, ?, ?, ?);";
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setString(1, modelLogin.getLogin());
			statement.setString(2, modelLogin.getSenha());
			statement.setString(3, modelLogin.getNome());
			statement.setString(4, modelLogin.getEmail());

			statement.execute();
			connection.commit();
			
			} else {
				String sql = "UPDATE public.model_login SET login=?, senha=?, nome=?, email=? "
						+ " WHERE id = "+ modelLogin.getId() +";";
				PreparedStatement statement = connection.prepareStatement(sql);
				statement.setString(1, modelLogin.getLogin());
				statement.setString(2, modelLogin.getSenha());
				statement.setString(3, modelLogin.getNome());
				statement.setString(4, modelLogin.getEmail());
				
				statement.executeUpdate();
				connection.commit();
			}
			return this.consultaUsuario(modelLogin.getLogin());
	}
	
	public List<ModelLogin> consultaListPorNome(String nome) throws SQLException{
		List<ModelLogin> retorno = new ArrayList<ModelLogin>();
		
		String sql = "SELECT * FROM model_login WHERE upper(nome) like upper('%" + nome + "%')";
		PreparedStatement statement = connection.prepareStatement(sql);
		ResultSet resultado = statement.executeQuery();
		while(resultado.next()) {/*percorre as linhas de resultado do sql */
			ModelLogin modelLogin = new ModelLogin();
			modelLogin.setEmail(resultado.getString("email"));
			modelLogin.setId(resultado.getLong("id"));
			modelLogin.setLogin(resultado.getString("login"));
			modelLogin.setNome(resultado.getString("nome"));
			retorno.add(modelLogin);
		}
		return retorno;
	}
	
	/**
	 * Método para consultar usuários
	 * @param loginUsuario
	 * @return
	 */
	public ModelLogin consultaUsuario(String loginUsuario) {
		
		ModelLogin modelLogin = new ModelLogin();
		try {
			String sql = "SELECT * FROM model_login WHERE upper(login) = upper('" + loginUsuario + "');";
			PreparedStatement statement = connection.prepareStatement(sql);
			ResultSet resultadoDaConsulta = statement.executeQuery();
			while (resultadoDaConsulta.next()) {
				modelLogin.setId(resultadoDaConsulta.getLong("id"));
				modelLogin.setNome(resultadoDaConsulta.getString("nome"));
				modelLogin.setEmail(resultadoDaConsulta.getString("email"));
				modelLogin.setLogin(resultadoDaConsulta.getString("login"));
				modelLogin.setSenha(resultadoDaConsulta.getString("senha"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return modelLogin;
	}
	
	public boolean validaLogin(String loginUsuario) {
		try {
			String sql = "select count(1) > 0 AS existe from model_login where upper(login) = upper('" + loginUsuario + "')";
			PreparedStatement statement = connection.prepareStatement(sql);
			ResultSet resultadoDaConsulta = statement.executeQuery();
			
			if (resultadoDaConsulta.next()) {/*o next é pra ele entrar nos resultados*/
				return resultadoDaConsulta.getBoolean("existe");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	public void deletarUsuario(String idUsuario)throws Exception {
		String sql = "DELETE FROM model_login WHERE id = ?;";
		PreparedStatement statement = connection.prepareStatement(sql);
		statement.setLong(1, Long.parseLong(idUsuario));
		statement.executeUpdate();
		connection.commit();
	}

}
