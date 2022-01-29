package servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.DAOUsuarioRepository;
import model.ModelLogin;

@WebServlet("/ServletTelefone")
public class ServletTelefone extends ServletGenericUtil {

	private static final long serialVersionUID = 1L;

	private DAOUsuarioRepository usuarioRepository = new DAOUsuarioRepository();

	public ServletTelefone() {
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {

			String idUser = request.getParameter("idUser");
			// System.out.println(idUser);

			if (idUser != null && !idUser.isEmpty()) {

				ModelLogin modelLogin = usuarioRepository.consultaUsuarioPorID(Long.parseLong(idUser));

				// passa o usuário e objeto inteiro
				request.setAttribute("usuario", modelLogin);
				request.getRequestDispatcher("principal/telefone.jsp").forward(request, response);

			} else {

				// consulta os dados no banco
				List<ModelLogin> modelLogins = usuarioRepository.consultaUsuarioLista(super.getUserLogado(request));
				// depois seta os atributos do usuario na tabela
				request.setAttribute("modelLogins", modelLogins);
				request.setAttribute("totalPagina", usuarioRepository.totalDePaginas(this.getUserLogado(request)));
				request.getRequestDispatcher("principal/cad_usuario.jsp").forward(request, response);

			}

		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

}
