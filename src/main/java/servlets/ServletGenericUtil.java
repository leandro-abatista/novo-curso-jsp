package servlets;

import java.io.Serializable;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import dao.DAOUsuarioRepository;

public class ServletGenericUtil extends HttpServlet implements Serializable {

	private static final long serialVersionUID = 1L;
	
	//private Connection connection;
	private DAOUsuarioRepository repository = new DAOUsuarioRepository();
	
	/* n�o precisa desse construtor
	public ServletGenericUtil() {
		connection = SingleConnectionBanco.getConnection();
	}
	*/
	
	public Long getUserLogado(HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		//pegando o usu�rio logado na sess�o
		String usuarioLog = (String) session.getAttribute("usuarioLogado");
		//consulta o usu�rio no banco pelo login
		return repository.consultaUsuarioLogado(usuarioLog).getId();
	}
}
