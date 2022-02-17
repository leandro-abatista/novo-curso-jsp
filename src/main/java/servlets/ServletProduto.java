package servlets;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.DAOProdutoRepository;
import model.Produto;

@WebServlet("/ServletProdutoController")
public class ServletProduto extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	private DAOProdutoRepository produtoRepository = new DAOProdutoRepository();

	public ServletProduto() {
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.getRequestDispatcher("principal/cad_produto.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {

			String id = request.getParameter("id");
			String descricao = request.getParameter("descricao");
			String quantidade = request.getParameter("quantidade");
			String dataEntrada = request.getParameter("dataEntrada");

			Produto produto = new Produto();
			produto.setId(id != null && !id.isEmpty() ? Long.parseLong(id) : null);
			produto.setDescricao(descricao);
			produto.setQuantidade(Integer.valueOf(quantidade));
			produto.setDataEntrada(Date.valueOf(dataEntrada));
			
			
			produto = produtoRepository.gravarProduto(produto);
			request.setAttribute("mensagem", "Registro salvo com sucesso!");
			RequestDispatcher redirecionaAPagina = request.getRequestDispatcher("principal/cad_produto.jsp");
			redirecionaAPagina.forward(request, response);
			//SETA O OBJETO NA TELA
			request.setAttribute("produto", produto);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
