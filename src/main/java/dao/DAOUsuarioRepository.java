package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import connection.SingleConnectionBanco;
import model.ModelLogin;

public class DAOUsuarioRepository {

	private Connection connection;

	public DAOUsuarioRepository() {
		connection = SingleConnectionBanco.getConnection();
	}

	public ModelLogin gravarUsuario(ModelLogin modelLogin) {
		try {
			String sql = "INSERT INTO public.model_login(login, senha, nome, email) VALUES (?, ?, ?, ?);";
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setString(1, modelLogin.getLogin());
			statement.setString(2, modelLogin.getSenha());
			statement.setString(3, modelLogin.getNome());
			statement.setString(4, modelLogin.getEmail());

			statement.execute();
			connection.commit();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return this.consultaUsuario(modelLogin.getLogin());
	}
	
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

}
