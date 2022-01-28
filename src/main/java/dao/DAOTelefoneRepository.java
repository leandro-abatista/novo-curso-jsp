package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import connection.SingleConnectionBanco;
import model.ModelTelefone;

public class DAOTelefoneRepository {

	private Connection connection;
	
	private DAOUsuarioRepository usuarioRepository = new DAOUsuarioRepository();
	
	public DAOTelefoneRepository() {
		connection = SingleConnectionBanco.getConnection();
	}
	
	public void gravarTelefone(ModelTelefone modelTelefone) throws Exception {
		
		String sql = "INSERT INTO public.telefone("
				+ "	numero, usuario_pai_id, usuario_cad_id)"
				+ "	VALUES (?, ?, ?);";
		
		PreparedStatement statement = connection.prepareStatement(sql);
		
		statement.setString(1, modelTelefone.getNumero());
		statement.setLong(2, modelTelefone.getUsuario_pai_id().getId());
		statement.setLong(3, modelTelefone.getUsuario_cad_id().getId());
		
		statement.execute();
		connection.commit();
	}
	
	public List<ModelTelefone> listaDeTelefonesUsers(Long idUserPai) throws Exception{
		
		List<ModelTelefone> retornoLista = new ArrayList<ModelTelefone>();
		
		String sql = "SELECT * FROM telefone WHERE usuario_pai_id = ?";
		
		PreparedStatement statement = connection.prepareStatement(sql);
		
		ResultSet resultado = statement.executeQuery();
		
		while(resultado.next()) {
			
			ModelTelefone modelTelefone = new ModelTelefone();
			modelTelefone.setIdFoneUser(resultado.getLong("idFoneUser"));
			modelTelefone.setNumero(resultado.getString("numero"));
			modelTelefone.setUsuario_cad_id(usuarioRepository.consultaUsuarioPorID(resultado.getLong("usuario_cad_id")));
			modelTelefone.setUsuario_pai_id(usuarioRepository.consultaUsuarioPorID(resultado.getLong("usuario_pai_id")));
			
			retornoLista.add(modelTelefone);
		}
		
		
		return retornoLista;
	}
	
	
	public void deletarTelefone(Long idFoneUser) throws Exception {
	
		String sql = "DELETE FROM public.telefone"
				+ "	WHERE idFoneUser = ?";
		
		PreparedStatement statement = connection.prepareStatement(sql);
		
		statement.setLong(1, idFoneUser);
		
		statement.executeUpdate();
		connection.commit();
	}
}
