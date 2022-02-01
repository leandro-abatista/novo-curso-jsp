package servlets;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
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
				request.setAttribute("totalPagina", daoUsuarioRepository.totalDePaginas(this.getUserLogado(request)));
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
				 
				 response.addDateHeader("totalPagina", 
						 daoUsuarioRepository.consultaOTotalUsuariosListEPaginaPaginacao(nomeBusca, super.getUserLogado(request)));
				 response.getWriter().write(json);
				 
				
			} else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("buscaUsuarioComAjaxPage")) {
				
				String nomeBusca = request.getParameter("nomeBusca");
				String pagenation = request.getParameter("Pagenation");
				
				
				List<ModelLogin> dadosJsonUser = daoUsuarioRepository.consultaListPorNome(nomeBusca, super.getUserLogado(request));
				//response.getWriter().write("Registro excluído com sucesso!");
				//System.out.println(nomeBusca);
				 ObjectMapper mapper = new ObjectMapper();
				 String json = mapper.writeValueAsString(dadosJsonUser);
				 
				 response.addDateHeader("totalPagina", 
						 daoUsuarioRepository.consultaOTotalUsuariosListEPaginaPaginacao(nomeBusca, super.getUserLogado(request)));
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
				request.setAttribute("totalPagina", daoUsuarioRepository.totalDePaginas(this.getUserLogado(request)));
				request.getRequestDispatcher("principal/cad_usuario.jsp").forward(request, response);
				
			} else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("mostrarDetalhes")) {
				
				String idUser = request.getParameter("id");
				ModelLogin modelLogin = daoUsuarioRepository.consultaUsuarioPorID(idUser, super.getUserLogado(request));
				request.setAttribute("modelLogin", modelLogin);
				request.setAttribute("totalPagina", daoUsuarioRepository.totalDePaginas(this.getUserLogado(request)));
				
			} else if(acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("listarUsuarios")) {
				
				List<ModelLogin> modelLogins = daoUsuarioRepository.consultaUsuarioLista(super.getUserLogado(request));
				
				request.setAttribute("mensagem", "Usuários carregados!");
				request.setAttribute("modelLogins", modelLogins);
				request.setAttribute("totalPagina", daoUsuarioRepository.totalDePaginas(this.getUserLogado(request)));
				request.getRequestDispatcher("principal/cad_usuario.jsp").forward(request, response);
				
			} else if(acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("downloadFoto")) {
				
				/*pegando o id do usuário*/
				String idUser = request.getParameter("id");
				ModelLogin modelLogin = daoUsuarioRepository.consultaUsuarioPorID(idUser, super.getUserLogado(request));
				if (modelLogin.getFotoUsuario() != null && !modelLogin.getFotoUsuario().isEmpty()) {
					/*codigo para o navegador fazer o download*/
					response.setHeader("Content-Disposition", "attachment;filename=arquivo." + modelLogin.getExtensaoFotoUsuario());
					
					response.getOutputStream().write(new Base64().decodeBase64(modelLogin.getFotoUsuario().split("\\,")[1]));
				}
				
			} else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("paginar")) {
				
				Integer offset = Integer.parseInt(request.getParameter("pagina"));
				List<ModelLogin> modelLogins = daoUsuarioRepository.consultaUsuarioListaPaginada(this.getUserLogado(request), offset);
				request.setAttribute("modelLogins", modelLogins);
				request.setAttribute("totalPagina", daoUsuarioRepository.totalDePaginas(this.getUserLogado(request)));
				request.getRequestDispatcher("principal/cad_usuario.jsp").forward(request, response);
						
			} else {
				
				//consulta os dados no banco
				List<ModelLogin> modelLogins = daoUsuarioRepository.consultaUsuarioLista(super.getUserLogado(request));
				//depois seta os atributos do usuario na tabela
				request.setAttribute("modelLogins", modelLogins);
				request.setAttribute("totalPagina", daoUsuarioRepository.totalDePaginas(this.getUserLogado(request)));
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
			String cep = request.getParameter("cep");
			String logradouro = request.getParameter("logradouro");
			String numero = request.getParameter("numero");
			String complemento = request.getParameter("complemento");
			String bairro = request.getParameter("bairro");
			String cidade = request.getParameter("cidade");
			String uf = request.getParameter("uf");
			String dataNascimento = request.getParameter("dataNascimento");
			
			

			ModelLogin modelLogin = new ModelLogin();
			//seta os dados para este objeto
			modelLogin.setId(id != null && !id.isEmpty() ? Long.parseLong(id) : null);
			modelLogin.setNome(nome);
			modelLogin.setEmail(email);
			modelLogin.setLogin(login);
			modelLogin.setSenha(senha);
			modelLogin.setPerfil(perfil);
			modelLogin.setSexo(sexo);
			modelLogin.setCep(cep);
			modelLogin.setLogradouro(logradouro);
			modelLogin.setNumero(numero);
			modelLogin.setComplemento(complemento);
			modelLogin.setBairro(bairro);
			modelLogin.setCidade(cidade);
			modelLogin.setUf(uf);
			modelLogin.setDataNascimento(new Date(new SimpleDateFormat("dd/mm/yyyy").parse(dataNascimento).getTime()));

			/*código abaixo é referente ao upload de fotos/imagem*/
			if (ServletFileUpload.isMultipartContent(request)) {
				
				Part part = request.getPart("fileFoto");/*pega a foto da tela*/
				
				if(part != null && part.getSize() > 0) {
 					
					byte[] foto = IOUtils.toByteArray(part.getInputStream());
					String imagemBase64 = "data:image/" + part.getContentType().split("\\/")[1] + ";base64," + new Base64().encodeBase64String(foto);
					System.out.println(imagemBase64);
					//IOUtils.toByteArray(part.getInputStream());/*converte imagem para byte*/
					//se tiver tudo certo
					modelLogin.setFotoUsuario(imagemBase64);
					modelLogin.setExtensaoFotoUsuario(part.getContentType().split("\\/")[1]);
				}
				
				
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
			request.setAttribute("totalPagina", daoUsuarioRepository.totalDePaginas(this.getUserLogado(request)));
			redireciona.forward(request, response);
			
		} catch (Exception e) {
			e.printStackTrace();
			RequestDispatcher redirecionar = request.getRequestDispatcher("/error/erro.jsp");
			request.setAttribute("msg", e.getMessage());
			redirecionar.forward(request, response);
		}
	}

}
