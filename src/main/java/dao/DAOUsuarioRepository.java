package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;


import connection.SingleConnectionBanco;
import model.ModelLogin;
import model.ModelTelefone;

public class DAOUsuarioRepository {

	private Connection connection;
	
	public DAOUsuarioRepository() {
		connection = SingleConnectionBanco.getConnection();
	}

	public ModelLogin gravarUsuario(ModelLogin modelLogin, Long userLogado) throws SQLException {

		if (modelLogin.isNovo()) {/* grava um novo */

			String sql = "INSERT INTO "
					+ " model_login(login, senha, nome, email, usuario_id, perfil, sexo, cep, logradouro, numero, complemento, bairro, cidade, uf, datanascimento, rendamensal) "
					+ " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setString(1, modelLogin.getLogin());
			statement.setString(2, modelLogin.getSenha());
			statement.setString(3, modelLogin.getNome());
			statement.setString(4, modelLogin.getEmail());
			statement.setLong(5, userLogado);
			statement.setString(6, modelLogin.getPerfil());
			statement.setString(7, modelLogin.getSexo());
			statement.setString(8, modelLogin.getCep());
			statement.setString(9, modelLogin.getLogradouro());
			statement.setString(10, modelLogin.getNumero());
			statement.setString(11, modelLogin.getComplemento());
			statement.setString(12, modelLogin.getBairro());
			statement.setString(13, modelLogin.getCidade());
			statement.setString(14, modelLogin.getUf());
			statement.setDate(15, modelLogin.getDataNascimento());
			statement.setDouble(16, modelLogin.getRendaMensal());

			statement.execute();
			connection.commit();

			/* se tiver foto ou imagem */
			if (modelLogin.getFotoUsuario() != null && !modelLogin.getFotoUsuario().isEmpty()) {
				sql = "update model_login set fotousuario = ?, extensaofotousuario = ? where login = ?";
				statement = connection.prepareStatement(sql);
				statement.setString(1, modelLogin.getFotoUsuario());
				statement.setString(2, modelLogin.getExtensaoFotoUsuario());
				statement.setString(3, modelLogin.getLogin());

				statement.execute();
				connection.commit();
			}

		} else {
			String sql = "UPDATE public.model_login SET login=?, senha=?, nome=?, email=?, perfil=?, sexo=? , cep=?, logradouro=?, numero=?, complemento=?, bairro=?, cidade=?, uf=?, datanascimento=?, rendamensal=? "
					+ " WHERE id = " + modelLogin.getId() + ";";
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setString(1, modelLogin.getLogin());
			statement.setString(2, modelLogin.getSenha());
			statement.setString(3, modelLogin.getNome());
			statement.setString(4, modelLogin.getEmail());
			statement.setString(5, modelLogin.getPerfil());
			statement.setString(6, modelLogin.getSexo());
			statement.setString(7, modelLogin.getCep());
			statement.setString(8, modelLogin.getLogradouro());
			statement.setString(9, modelLogin.getNumero());
			statement.setString(10, modelLogin.getComplemento());
			statement.setString(11, modelLogin.getBairro());
			statement.setString(12, modelLogin.getCidade());
			statement.setString(13, modelLogin.getUf());
			statement.setDate(14, modelLogin.getDataNascimento());
			statement.setDouble(15, modelLogin.getRendaMensal());

			statement.executeUpdate();
			connection.commit();

			/* se tiver foto ou imagem */
			if (modelLogin.getFotoUsuario() != null && !modelLogin.getFotoUsuario().isEmpty()) {
				sql = "update model_login set fotousuario = ?, extensaofotousuario = ? where id = ?";
				statement = connection.prepareStatement(sql);
				statement.setString(1, modelLogin.getFotoUsuario());
				statement.setString(2, modelLogin.getExtensaoFotoUsuario());
				statement.setLong(3, modelLogin.getId());

				statement.execute();
				connection.commit();
			}
		}
		return this.consultaUsuario(modelLogin.getLogin(), userLogado);
	}

	/**
	 * Método de paginação por página com ajax
	 * 
	 * @param nome
	 * @param userLogado
	 * @return
	 * @throws SQLException
	 */
	public int consultaOTotalUsuariosListEPaginaPaginacao(String nome, Long userLogado) throws SQLException {

		String sql = "SELECT count(1) as total FROM model_login " + " WHERE upper(nome) like upper('%" + nome + "%') "
				+ " and useradmin is false and usuario_id = " + userLogado;

		PreparedStatement statement = connection.prepareStatement(sql);
		ResultSet resultadoDaConsulta = statement.executeQuery();
		resultadoDaConsulta.next();

		Double totalDeCadastros = resultadoDaConsulta.getDouble("total");
		Double totalPorPaginas = 5.0;
		Double numeroDePaginas = totalDeCadastros / totalPorPaginas;
		Double resto = numeroDePaginas % 2;
		if (resto > 0) {
			numeroDePaginas++;// se o resto for maior que zero, soma +1
		}

		return numeroDePaginas.intValue();
	}

	public List<ModelLogin> consultaListPorNome(String nome, Long userLogado) throws SQLException {
		List<ModelLogin> retorno = new ArrayList<ModelLogin>();

		String sql = "SELECT * FROM model_login WHERE upper(nome) like upper('%" + nome
				+ "%') and useradmin is false and usuario_id = " + userLogado + " order by id";
		PreparedStatement statement = connection.prepareStatement(sql);
		ResultSet resultado = statement.executeQuery();
		while (resultado.next()) {/* percorre as linhas de resultado do sql */
			ModelLogin modelLogin = new ModelLogin();
			modelLogin.setEmail(resultado.getString("email"));
			modelLogin.setId(resultado.getLong("id"));
			modelLogin.setLogin(resultado.getString("login"));
			modelLogin.setNome(resultado.getString("nome"));
			modelLogin.setPerfil(resultado.getString("perfil"));
			modelLogin.setSexo(resultado.getString("sexo"));

			retorno.add(modelLogin);
		}
		return retorno;
	}

	/**
	 * Método para consultar usuários
	 * 
	 * @param loginUsuario
	 * @return
	 */
	public ModelLogin consultaUsuario(String login, Long userLogado) {

		ModelLogin modelLogin = new ModelLogin();
		try {
			String sql = "SELECT * FROM model_login WHERE upper(login) = upper('" + login
					+ "') and useradmin is false and usuario_id = " + userLogado;
			PreparedStatement statement = connection.prepareStatement(sql);
			ResultSet resultadoDaConsulta = statement.executeQuery();
			while (resultadoDaConsulta.next()) {
				modelLogin.setId(resultadoDaConsulta.getLong("id"));
				modelLogin.setNome(resultadoDaConsulta.getString("nome"));
				modelLogin.setEmail(resultadoDaConsulta.getString("email"));
				modelLogin.setLogin(resultadoDaConsulta.getString("login"));
				modelLogin.setSenha(resultadoDaConsulta.getString("senha"));
				modelLogin.setPerfil(resultadoDaConsulta.getString("perfil"));
				modelLogin.setSexo(resultadoDaConsulta.getString("sexo"));
				modelLogin.setFotoUsuario(resultadoDaConsulta.getString("fotousuario"));
				modelLogin.setCep(resultadoDaConsulta.getString("cep"));
				modelLogin.setLogradouro(resultadoDaConsulta.getString("logradouro"));
				modelLogin.setNumero(resultadoDaConsulta.getString("numero"));
				modelLogin.setComplemento(resultadoDaConsulta.getString("complemento"));
				modelLogin.setBairro(resultadoDaConsulta.getString("bairro"));
				modelLogin.setCidade(resultadoDaConsulta.getString("cidade"));
				modelLogin.setUf(resultadoDaConsulta.getString("uf"));
				modelLogin.setDataNascimento(resultadoDaConsulta.getDate("datanascimento"));
				modelLogin.setRendaMensal(resultadoDaConsulta.getDouble("rendamensal"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return modelLogin;
	}

	public ModelLogin consultaUsuario(String login) {

		ModelLogin modelLogin = new ModelLogin();
		try {
			String sql = "SELECT * FROM model_login WHERE upper(login) = upper('" + login + "') and useradmin is false";
			PreparedStatement statement = connection.prepareStatement(sql);
			ResultSet resultadoDaConsulta = statement.executeQuery();
			while (resultadoDaConsulta.next()) {
				modelLogin.setId(resultadoDaConsulta.getLong("id"));
				modelLogin.setNome(resultadoDaConsulta.getString("nome"));
				modelLogin.setEmail(resultadoDaConsulta.getString("email"));
				modelLogin.setLogin(resultadoDaConsulta.getString("login"));
				modelLogin.setSenha(resultadoDaConsulta.getString("senha"));
				modelLogin.setUserAdmin(resultadoDaConsulta.getBoolean("useradmin"));
				modelLogin.setPerfil(resultadoDaConsulta.getString("perfil"));
				modelLogin.setSexo(resultadoDaConsulta.getString("sexo"));
				modelLogin.setFotoUsuario(resultadoDaConsulta.getString("fotousuario"));
				modelLogin.setCep(resultadoDaConsulta.getString("cep"));
				modelLogin.setLogradouro(resultadoDaConsulta.getString("logradouro"));
				modelLogin.setNumero(resultadoDaConsulta.getString("numero"));
				modelLogin.setComplemento(resultadoDaConsulta.getString("complemento"));
				modelLogin.setBairro(resultadoDaConsulta.getString("bairro"));
				modelLogin.setCidade(resultadoDaConsulta.getString("cidade"));
				modelLogin.setUf(resultadoDaConsulta.getString("uf"));
				modelLogin.setDataNascimento(resultadoDaConsulta.getDate("datanascimento"));
				modelLogin.setRendaMensal(resultadoDaConsulta.getDouble("rendamensal"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return modelLogin;
	}

	public ModelLogin consultaUsuarioLogado(String login) {

		ModelLogin modelLogin = new ModelLogin();
		try {
			String sql = "SELECT * FROM model_login WHERE upper(login) = upper('" + login + "')";
			PreparedStatement statement = connection.prepareStatement(sql);
			ResultSet resultadoDaConsulta = statement.executeQuery();
			while (resultadoDaConsulta.next()) {
				modelLogin.setId(resultadoDaConsulta.getLong("id"));
				modelLogin.setNome(resultadoDaConsulta.getString("nome"));
				modelLogin.setEmail(resultadoDaConsulta.getString("email"));
				modelLogin.setLogin(resultadoDaConsulta.getString("login"));
				modelLogin.setSenha(resultadoDaConsulta.getString("senha"));
				modelLogin.setUserAdmin(resultadoDaConsulta.getBoolean("useradmin"));
				modelLogin.setPerfil(resultadoDaConsulta.getString("perfil"));
				modelLogin.setSexo(resultadoDaConsulta.getString("sexo"));
				modelLogin.setFotoUsuario(resultadoDaConsulta.getString("fotousuario"));
				modelLogin.setCep(resultadoDaConsulta.getString("cep"));
				modelLogin.setLogradouro(resultadoDaConsulta.getString("logradouro"));
				modelLogin.setNumero(resultadoDaConsulta.getString("numero"));
				modelLogin.setComplemento(resultadoDaConsulta.getString("complemento"));
				modelLogin.setBairro(resultadoDaConsulta.getString("bairro"));
				modelLogin.setCidade(resultadoDaConsulta.getString("cidade"));
				modelLogin.setUf(resultadoDaConsulta.getString("uf"));
				modelLogin.setDataNascimento(resultadoDaConsulta.getDate("datanascimento"));
				modelLogin.setRendaMensal(resultadoDaConsulta.getDouble("rendamensal"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return modelLogin;
	}

	public boolean validaLogin(String loginUsuario) {
		try {
			String sql = "select count(1) > 0 AS existe from model_login where upper(login) = upper('" + loginUsuario
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

	public void deletarUsuario(String idUsuario) throws Exception {
		String sql = "DELETE FROM model_login WHERE id = ? and useradmin is false;";
		PreparedStatement statement = connection.prepareStatement(sql);
		statement.setLong(1, Long.parseLong(idUsuario));
		statement.executeUpdate();
		connection.commit();
	}
	
	
	public List<ModelLogin> consultaUsuarioListaRelatorio(Long userLogado) throws Exception {

		List<ModelLogin> retorno = new ArrayList<ModelLogin>();
		String sql = "SELECT * FROM model_login WHERE useradmin is false and usuario_id = " + userLogado
				+ " order by id";
		PreparedStatement statement = connection.prepareStatement(sql);
		ResultSet resultadoDaConsulta = statement.executeQuery();

		while (resultadoDaConsulta.next()) {
			ModelLogin modelLogin = new ModelLogin();
			modelLogin.setId(resultadoDaConsulta.getLong("id"));
			modelLogin.setNome(resultadoDaConsulta.getString("nome"));
			modelLogin.setEmail(resultadoDaConsulta.getString("email"));
			modelLogin.setLogin(resultadoDaConsulta.getString("login"));
			//modelLogin.setSenha(resultadoDaConsulta.getString("senha"));
			modelLogin.setPerfil(resultadoDaConsulta.getString("perfil"));
			modelLogin.setSexo(resultadoDaConsulta.getString("sexo"));
			modelLogin.setCep(resultadoDaConsulta.getString("cep"));
			modelLogin.setLogradouro(resultadoDaConsulta.getString("logradouro"));
			modelLogin.setNumero(resultadoDaConsulta.getString("numero"));
			modelLogin.setComplemento(resultadoDaConsulta.getString("complemento"));
			modelLogin.setBairro(resultadoDaConsulta.getString("bairro"));
			modelLogin.setCidade(resultadoDaConsulta.getString("cidade"));
			modelLogin.setUf(resultadoDaConsulta.getString("uf"));
			modelLogin.setDataNascimento(resultadoDaConsulta.getDate("datanascimento"));
			modelLogin.setRendaMensal(resultadoDaConsulta.getDouble("rendamensal"));
			
			modelLogin.setTelefones(this.listaDeTelefonesUsers(modelLogin.getId()));

			retorno.add(modelLogin);
		}

		return retorno;
	}
	
	
	public List<ModelLogin> consultaUsuarioListaRelatorio(Long userLogado, String dataInicial, String dataFinal) 
			throws Exception {

		List<ModelLogin> retorno = new ArrayList<ModelLogin>();
		String sql = "SELECT * FROM model_login WHERE useradmin is false and usuario_id = " + userLogado
				+ " and datanascimento >= ? "
				+ " and datanascimento <= ? ";
		PreparedStatement statement = connection.prepareStatement(sql);
		statement.setDate(1, Date.valueOf(new SimpleDateFormat("yyyy-mm-dd").format(new SimpleDateFormat("dd/mm/yyyy").parse(dataInicial))));
		statement.setDate(2, Date.valueOf(new SimpleDateFormat("yyyy-mm-dd").format(new SimpleDateFormat("dd/mm/yyyy").parse(dataFinal))));
		ResultSet resultadoDaConsulta = statement.executeQuery();

		while (resultadoDaConsulta.next()) {
			ModelLogin modelLogin = new ModelLogin();
			modelLogin.setId(resultadoDaConsulta.getLong("id"));         
			modelLogin.setNome(resultadoDaConsulta.getString("nome"));
			modelLogin.setEmail(resultadoDaConsulta.getString("email"));
			modelLogin.setLogin(resultadoDaConsulta.getString("login"));
			//modelLogin.setSenha(resultadoDaConsulta.getString("senha"));
			modelLogin.setPerfil(resultadoDaConsulta.getString("perfil"));
			modelLogin.setSexo(resultadoDaConsulta.getString("sexo"));
			modelLogin.setCep(resultadoDaConsulta.getString("cep"));
			modelLogin.setLogradouro(resultadoDaConsulta.getString("logradouro"));
			modelLogin.setNumero(resultadoDaConsulta.getString("numero"));
			modelLogin.setComplemento(resultadoDaConsulta.getString("complemento"));
			modelLogin.setBairro(resultadoDaConsulta.getString("bairro"));
			modelLogin.setCidade(resultadoDaConsulta.getString("cidade"));
			modelLogin.setUf(resultadoDaConsulta.getString("uf"));
			modelLogin.setDataNascimento(resultadoDaConsulta.getDate("datanascimento"));
			modelLogin.setRendaMensal(resultadoDaConsulta.getDouble("rendamensal"));
			
			modelLogin.setTelefones(this.listaDeTelefonesUsers(modelLogin.getId()));

			retorno.add(modelLogin);
		}

		return retorno;
	}
	

	public List<ModelLogin> consultaUsuarioLista(Long userLogado) throws SQLException {

		List<ModelLogin> retorno = new ArrayList<ModelLogin>();
		String sql = "SELECT * FROM model_login WHERE useradmin is false and usuario_id = " + userLogado
				+ " order by id limit 5";
		PreparedStatement statement = connection.prepareStatement(sql);
		ResultSet resultadoDaConsulta = statement.executeQuery();

		while (resultadoDaConsulta.next()) {
			ModelLogin modelLogin = new ModelLogin();
			modelLogin.setId(resultadoDaConsulta.getLong("id"));
			modelLogin.setNome(resultadoDaConsulta.getString("nome"));
			modelLogin.setEmail(resultadoDaConsulta.getString("email"));
			modelLogin.setLogin(resultadoDaConsulta.getString("login"));
			//modelLogin.setSenha(resultadoDaConsulta.getString("senha"));
			modelLogin.setPerfil(resultadoDaConsulta.getString("perfil"));
			modelLogin.setSexo(resultadoDaConsulta.getString("sexo"));
			modelLogin.setCep(resultadoDaConsulta.getString("cep"));
			modelLogin.setLogradouro(resultadoDaConsulta.getString("logradouro"));
			modelLogin.setNumero(resultadoDaConsulta.getString("numero"));
			modelLogin.setComplemento(resultadoDaConsulta.getString("complemento"));
			modelLogin.setBairro(resultadoDaConsulta.getString("bairro"));
			modelLogin.setCidade(resultadoDaConsulta.getString("cidade"));
			modelLogin.setUf(resultadoDaConsulta.getString("uf"));
			modelLogin.setDataNascimento(resultadoDaConsulta.getDate("datanascimento"));
			modelLogin.setRendaMensal(resultadoDaConsulta.getDouble("rendamensal"));

			retorno.add(modelLogin);
		}

		return retorno;
	}

	public int totalDePaginas(Long userLogado) throws Exception {
		String sql = "select count(1) as total from model_login where usuario_id = " + userLogado;
		PreparedStatement statement = connection.prepareStatement(sql);
		ResultSet resultadoDaConsulta = statement.executeQuery();
		resultadoDaConsulta.next();

		Double totalDeCadastros = resultadoDaConsulta.getDouble("total");
		Double totalPorPaginas = 5.0;
		Double numeroDePaginas = totalDeCadastros / totalPorPaginas;
		Double resto = numeroDePaginas % 2;
		if (resto > 0) {
			numeroDePaginas++;// se o resto for maior que zero, soma +1
		}

		return numeroDePaginas.intValue();
	}

	/**
	 * Método de consulta paginada
	 * 
	 * @param userLogado
	 * @return
	 * @throws SQLException
	 */
	public List<ModelLogin> consultaUsuarioListaPaginada(Long userLogado, Integer offSet) throws SQLException {

		List<ModelLogin> retorno = new ArrayList<ModelLogin>();
		String sql = "SELECT * FROM model_login WHERE useradmin is false and usuario_id = " + userLogado
				+ " order by id offset " + offSet + " limit 5";
		PreparedStatement statement = connection.prepareStatement(sql);
		ResultSet resultadoDaConsulta = statement.executeQuery();

		while (resultadoDaConsulta.next()) {
			ModelLogin modelLogin = new ModelLogin();
			modelLogin.setId(resultadoDaConsulta.getLong("id"));
			modelLogin.setNome(resultadoDaConsulta.getString("nome"));
			modelLogin.setEmail(resultadoDaConsulta.getString("email"));
			modelLogin.setLogin(resultadoDaConsulta.getString("login"));
			modelLogin.setSenha(resultadoDaConsulta.getString("senha"));
			modelLogin.setPerfil(resultadoDaConsulta.getString("perfil"));
			modelLogin.setSexo(resultadoDaConsulta.getString("sexo"));
			modelLogin.setCep(resultadoDaConsulta.getString("cep"));
			modelLogin.setLogradouro(resultadoDaConsulta.getString("logradouro"));
			modelLogin.setNumero(resultadoDaConsulta.getString("numero"));
			modelLogin.setComplemento(resultadoDaConsulta.getString("complemento"));
			modelLogin.setBairro(resultadoDaConsulta.getString("bairro"));
			modelLogin.setCidade(resultadoDaConsulta.getString("cidade"));
			modelLogin.setUf(resultadoDaConsulta.getString("uf"));
			modelLogin.setDataNascimento(resultadoDaConsulta.getDate("datanascimento"));
			modelLogin.setRendaMensal(resultadoDaConsulta.getDouble("rendamensal"));

			retorno.add(modelLogin);
		}

		return retorno;
	}
	
	public ModelLogin consultaUsuarioPorID(Long id) throws Exception {

		ModelLogin modelLogin = new ModelLogin();

		String sql = "SELECT * FROM model_login WHERE id = ? and useradmin is false";
		
		PreparedStatement statement = connection.prepareStatement(sql);
		statement.setLong(1, id);

		ResultSet resultadoDaConsulta = statement.executeQuery();

		while (resultadoDaConsulta.next()) {

			modelLogin.setId(resultadoDaConsulta.getLong("id"));
			modelLogin.setNome(resultadoDaConsulta.getString("nome"));
			modelLogin.setEmail(resultadoDaConsulta.getString("email"));
			modelLogin.setLogin(resultadoDaConsulta.getString("login"));
			modelLogin.setSenha(resultadoDaConsulta.getString("senha"));
			modelLogin.setPerfil(resultadoDaConsulta.getString("perfil"));
			modelLogin.setSexo(resultadoDaConsulta.getString("sexo"));
			modelLogin.setFotoUsuario(resultadoDaConsulta.getString("fotousuario"));
			modelLogin.setExtensaoFotoUsuario(resultadoDaConsulta.getString("extensaofotousuario"));
			modelLogin.setCep(resultadoDaConsulta.getString("cep"));
			modelLogin.setLogradouro(resultadoDaConsulta.getString("logradouro"));
			modelLogin.setNumero(resultadoDaConsulta.getString("numero"));
			modelLogin.setComplemento(resultadoDaConsulta.getString("complemento"));
			modelLogin.setBairro(resultadoDaConsulta.getString("bairro"));
			modelLogin.setCidade(resultadoDaConsulta.getString("cidade"));
			modelLogin.setUf(resultadoDaConsulta.getString("uf"));
			modelLogin.setDataNascimento(resultadoDaConsulta.getDate("datanascimento"));
			modelLogin.setRendaMensal(resultadoDaConsulta.getDouble("rendamensal"));
		}

		return modelLogin;
	}

	public ModelLogin consultaUsuarioPorID(String id, Long userLogado) throws Exception {

		ModelLogin modelLogin = new ModelLogin();

		String sql = "SELECT * FROM model_login WHERE id = ? and useradmin is false and usuario_id = ?";
				
		PreparedStatement statement = connection.prepareStatement(sql);
		statement.setLong(1, Long.parseLong(id));
		statement.setLong(2, userLogado);

		ResultSet resultadoDaConsulta = statement.executeQuery();

		while (resultadoDaConsulta.next()) {

			modelLogin.setId(resultadoDaConsulta.getLong("id"));
			modelLogin.setNome(resultadoDaConsulta.getString("nome"));
			modelLogin.setEmail(resultadoDaConsulta.getString("email"));
			modelLogin.setLogin(resultadoDaConsulta.getString("login"));
			modelLogin.setSenha(resultadoDaConsulta.getString("senha"));
			modelLogin.setPerfil(resultadoDaConsulta.getString("perfil"));
			modelLogin.setSexo(resultadoDaConsulta.getString("sexo"));
			modelLogin.setFotoUsuario(resultadoDaConsulta.getString("fotousuario"));
			modelLogin.setExtensaoFotoUsuario(resultadoDaConsulta.getString("extensaofotousuario"));
			modelLogin.setCep(resultadoDaConsulta.getString("cep"));
			modelLogin.setLogradouro(resultadoDaConsulta.getString("logradouro"));
			modelLogin.setNumero(resultadoDaConsulta.getString("numero"));
			modelLogin.setComplemento(resultadoDaConsulta.getString("complemento"));
			modelLogin.setBairro(resultadoDaConsulta.getString("bairro"));
			modelLogin.setCidade(resultadoDaConsulta.getString("cidade"));
			modelLogin.setUf(resultadoDaConsulta.getString("uf"));
			modelLogin.setDataNascimento(resultadoDaConsulta.getDate("datanascimento"));
			modelLogin.setRendaMensal(resultadoDaConsulta.getDouble("rendamensal"));
		}

		return modelLogin;
	}
	
	public List<ModelTelefone> listaDeTelefonesUsers(Long idUserPai) throws Exception {

		List<ModelTelefone> retornoLista = new ArrayList<ModelTelefone>();

		String sql = "SELECT * FROM telefone WHERE usuario_pai_id = ?";

		PreparedStatement statement = connection.prepareStatement(sql);

		statement.setLong(1, idUserPai);

		ResultSet resultado = statement.executeQuery();

		while (resultado.next()) {

			ModelTelefone modelTelefone = new ModelTelefone();
			modelTelefone.setIdFoneUser(resultado.getLong("idFoneUser"));
			modelTelefone.setNumero(resultado.getString("numero"));
			modelTelefone.setUsuario_cad_id(this.consultaUsuarioPorID(resultado.getLong("usuario_cad_id")));
			modelTelefone.setUsuario_pai_id(this.consultaUsuarioPorID(resultado.getLong("usuario_pai_id")));

			retornoLista.add(modelTelefone);
		}

		return retornoLista;
	}

}
