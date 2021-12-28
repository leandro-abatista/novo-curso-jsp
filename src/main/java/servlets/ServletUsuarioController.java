package servlets;

import java.io.IOException;
import java.util.List;

import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.commons.io.IOUtils;
import org.apache.tomcat.util.codec.binary.Base64;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import dao.DAOUsuarioRepository;
import model.ModelLogin;

@MultipartConfig
@WebServlet( urlPatterns = {"/ServletUsuarioController"})
public class ServletUsuarioController extends ServletGenericUtil {
	
	private static final long serialVersionUID = 1L;
	
	private DAOUsuarioRepository daoUsuarioRepository = new DAOUsuarioRepository();
       
    
    public ServletUsuarioController() {
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String acao = request.getParameter("acao");
			
			if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("deletar")) {
				
				String idUsuario = request.getParameter("id");
				daoUsuarioRepository.deletarUsuario(idUsuario);
				
				//consulta os dados no banco
				List<ModelLogin> modelLogins = daoUsuarioRepository.consultaUsuarioLista(super.getUserLogado(request));
				//depois seta os atributos do usuario na tabela
				request.setAttribute("modelLogins", modelLogins);
				
				request.setAttribute("mensagem", "Registro excluído com sucesso!");
				request.getRequestDispatcher("principal/cad_usuario.jsp").forward(request, response);
				
			} else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("deletarComAjax")) {/* usando o ajax para deletar usuário */
				
				String idUsuario = request.getParameter("id");
				daoUsuarioRepository.deletarUsuario(idUsuario);
				response.getWriter().write("Registro excluído com sucesso!");
				
			} else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("buscaUsuarioComAjax")) {
				
				String nomeBusca = request.getParameter("nomeBusca");
				List<ModelLogin> dadosJsonUser = daoUsuarioRepository.consultaListPorNome(nomeBusca, super.getUserLogado(request));
				//response.getWriter().write("Registro excluído com sucesso!");
				//System.out.println(nomeBusca);
				 ObjectMapper mapper = new ObjectMapper();
				 String json = mapper.writeValueAsString(dadosJsonUser);
				 response.getWriter().write(json);
				
			} else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("buscarEditar")) {
				
				String idUser = request.getParameter("id");
				ModelLogin modelLogin = daoUsuarioRepository.consultaUsuarioPorID(idUser, super.getUserLogado(request));
				
				//consulta os dados no banco
				List<ModelLogin> modelLogins = daoUsuarioRepository.consultaUsuarioLista(super.getUserLogado(request));
				//depois seta os atributos do usuario na tabela
				request.setAttribute("modelLogins", modelLogins);
				
				request.setAttribute("mensagem", "Usuário em edição!");
				request.setAttribute("modelLogin", modelLogin);
				request.getRequestDispatcher("principal/cad_usuario.jsp").forward(request, response);
				
			} else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("mostrarDetalhes")) {
				
				String idUser = request.getParameter("id");
				ModelLogin modelLogin = daoUsuarioRepository.consultaUsuarioPorID(idUser, super.getUserLogado(request));
				
				request.setAttribute("modelLogin", modelLogin);
				
			} else if(acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("listarUsuarios")) {
				
				List<ModelLogin> modelLogins = daoUsuarioRepository.consultaUsuarioLista(super.getUserLogado(request));
				
				request.setAttribute("mensagem", "Usuários carregados!");
				request.setAttribute("modelLogins", modelLogins);
				request.getRequestDispatcher("principal/cad_usuario.jsp").forward(request, response);
			}
			else {
				
				//consulta os dados no banco
				List<ModelLogin> modelLogins = daoUsuarioRepository.consultaUsuarioLista(super.getUserLogado(request));
				//depois seta os atributos do usuario na tabela
				request.setAttribute("modelLogins", modelLogins);
				request.getRequestDispatcher("principal/cad_usuario.jsp").forward(request, response);
				
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
			RequestDispatcher redirecionar = request.getRequestDispatcher("/error/erro.jsp");
			request.setAttribute("msg", e.getMessage());
			redirecionar.forward(request, response);
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			
			String mensagem = "Operação realizada com sucesso!";
			
			String id = request.getParameter("id");
			String nome = request.getParameter("nome");
			String email = request.getParameter("email");
			String login = request.getParameter("login");
			String senha = request.getParameter("senha");
			String perfil = request.getParameter("perfil");
			String sexo = request.getParameter("sexo");
			

			ModelLogin modelLogin = new ModelLogin();
			//seta os dados para este objeto
			modelLogin.setId(id != null && !id.isEmpty() ? Long.parseLong(id) : null);
			modelLogin.setNome(nome);
			modelLogin.setEmail(email);
			modelLogin.setLogin(login);
			modelLogin.setSenha(senha);
			modelLogin.setPerfil(perfil);
			modelLogin.setSexo(sexo);
			

			/*código abaixo é referente ao upload de fotos/imagem*/
			if (ServletFileUpload.isMultipartContent(request)) {
				Part part = request.getPart("fileFoto");/*pega a foto da tela*/
				byte[] foto = IOUtils.toByteArray(part.getInputStream());
				String imagemBase64 = "data:image/" + part.getContentType().split("\\/")[1] + ";base64," + new Base64().encodeBase64String(foto);
				System.out.println(imagemBase64);
				//IOUtils.toByteArray(part.getInputStream());/*converte imagem para byte*/
				
				//se tiver tudo certo
				modelLogin.setFotoUsuario(imagemBase64);
				modelLogin.setExtensaoFotoUsuario(part.getContentType().split("\\/")[1]);
				
			}

			if (daoUsuarioRepository.validaLogin(modelLogin.getLogin()) && modelLogin.getId() == null) {
				mensagem = "Já existe um usuario com o mesmo 'Login'.\nInforme um login válido!";
			} else {
				
				if(modelLogin.isNovo()){
					mensagem = "Registro gravado com sucesso!";
				} else {
					mensagem = "Registro atualizado com sucesso!";
				}
				
				modelLogin = daoUsuarioRepository.gravarUsuario(modelLogin, super.getUserLogado(request));
			}
			
			//consulta os dados no banco
			List<ModelLogin> modelLogins = daoUsuarioRepository.consultaUsuarioLista(super.getUserLogado(request));
			//depois seta os atributos do usuario na tabela
			request.setAttribute("modelLogins", modelLogins);

			request.setAttribute("mensagem", mensagem);
			//request.setAttribute("modelLogin", modelLogin);
			RequestDispatcher redireciona = request.getRequestDispatcher("principal/cad_usuario.jsp");
			/* seta os atributos de ModelLogin na tela */
			request.setAttribute("modelLogin", modelLogin);
			redireciona.forward(request, response);
			
		} catch (Exception e) {
			e.printStackTrace();
			RequestDispatcher redirecionar = request.getRequestDispatcher("/error/erro.jsp");
			request.setAttribute("msg", e.getMessage());
			redirecionar.forward(request, response);
		}
	}

}
