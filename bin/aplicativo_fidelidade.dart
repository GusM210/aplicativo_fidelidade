import 'dart:io';

class Cartao {
  String numero;
  String tipo;

  Cartao(this.numero, this.tipo);
}

class Usuario {
  int id;
  String username;
  String email;
  String _senha;
  String telefone;
  List<Cartao> cartoes = [];

  Usuario(this.id, this.username, this.email, this._senha, this.telefone);

  Usuario.criarConta(
      String username, String email, String senha, String telefone)
      : this(0, username, email, senha, telefone);

  void listarUsuario() {
    print('Usuário:');
    print('ID: $id');
    print('Nome de Usuário: $username');
    print('Email: $email');
    print('Telefone: $telefone');
    print('Número de Cartões: ${cartoes.length}');
  }

  void trocarSenha(String novaSenha) {
    _senha = novaSenha;
    print('Senha alterada com sucesso!');
  }

  bool fazerLogin(String senha) {
    if (senha == _senha) {
      print('Bem-vindo, $username!');
      return true;
    } else {
      print('Senha incorreta!');
      return false;
    }
  }

  void adicionarCartao(String numero, String tipo) {
    Cartao novoCartao = Cartao(numero, tipo);
    cartoes.add(novoCartao);
    print('Cartão adicionado com sucesso!');
  }

  void excluirConta() {
    print('Conta excluída com sucesso!');
  }
}

class UsuarioEmpresa extends Usuario {
  String cnpj;
  String razaoSocial;

  UsuarioEmpresa(int id, String username, String email, String senha,
      String telefone, this.cnpj, this.razaoSocial)
      : super(id, username, email, senha, telefone);

  UsuarioEmpresa.criarContaEmpresa(String username, String email, String senha,
      String telefone, String cnpj, String razaoSocial)
      : this(0, username, email, senha, telefone, cnpj, razaoSocial);
}

class Admin {
  var AdminList = [
    'augusto@gmail.com'
  ];

  void verificarAdmin(String email) {
    if (AdminList.contains(email)) {
      print('Bem-vindo, $email!');
    } else {
      print('Usuário não é um administrador.');
    }
  }
}

void main() {
  List<Usuario> usuarios = [
    Usuario(1, 'augusto', 'augusto@gmail.com', '123456', '123456789'),
  ];

  bool sair = false;

  while (!sair) {
    exibirMenu();
    String? opcao = stdin.readLineSync();

    switch (opcao) {
      case '1':
        fazerLogin(usuarios);
        break;

      case '2':
        criarConta(usuarios);
        break;

      case '3':
        sair = true;
        print('Saindo...');
        break;

      default:
        print('Opção inválida. Tente novamente.');
        break;
    }
  }
}

void exibirMenu() {
  print('Menu:');
  print('1. Login');
  print('2. Criar Conta');
  print('3. Sair');
  stdout.write('Escolha uma opção: ');
}

void fazerLogin(List<Usuario> usuarios) {
  print('Faça login');
  stdout.write('Email: ');
  String? email = stdin.readLineSync();
  stdout.write('Senha: ');
  String? senha = stdin.readLineSync();

  bool loginSucesso = false;

  Admin admin = Admin();
  admin.verificarAdmin(email!);

  for (var usuario in usuarios) {
    if (usuario.email == email) {
      loginSucesso = usuario.fazerLogin(senha!);
      if (loginSucesso) {
        while (loginSucesso) {
          print('Número de Cartões: ${usuario.cartoes.length}');
          print('Deseja adicionar um novo cartão? (S/N)');
          String? adicionarCartao = stdin.readLineSync();
          if (adicionarCartao?.toUpperCase() == 'S') {
            stdout.write('Número do Cartão: ');
            String? numeroCartao = stdin.readLineSync();
            stdout.write('Tipo do Cartão: ');
            String? tipoCartao = stdin.readLineSync();
            usuario.adicionarCartao(numeroCartao!, tipoCartao!);
          }
          break;
        }
      }
      break;
    }
  }
  if (!loginSucesso) {
    print('Usuário não encontrado ou senha incorreta.');
  }
}

void criarConta(List<Usuario> usuarios) {
  print('Criar Conta');
  print('1. Usuário Padrão');
  print('2. Empresa');
  stdout.write('Escolha o tipo de conta a ser criada: ');
  String? tipoConta = stdin.readLineSync();

  switch (tipoConta) {
    case '1':
      stdout.write('Nome de Usuário: ');
      String? username = stdin.readLineSync();
      stdout.write('Email: ');
      String? email = stdin.readLineSync();
      stdout.write('Senha: ');
      String? senha = stdin.readLineSync();
      stdout.write('Telefone: ');
      String? telefone = stdin.readLineSync();

      Usuario novoUsuario =
      Usuario.criarConta(username!, email!, senha!, telefone!);
      usuarios.add(novoUsuario);
      print('Conta de Usuário Padrão criada com sucesso!');
      break;

    case '2':
      stdout.write('Nome de Usuário: ');
      String? username = stdin.readLineSync();
      stdout.write('Email: ');
      String? email = stdin.readLineSync();
      stdout.write('Senha: ');
      String? senha = stdin.readLineSync();
      stdout.write('Telefone: ');
      String? telefone = stdin.readLineSync();
      stdout.write('CNPJ: ');
      String? cnpj = stdin.readLineSync();
      stdout.write('Razão Social: ');
      String? razaoSocial = stdin.readLineSync();

      UsuarioEmpresa novoUsuarioEmpresa = UsuarioEmpresa.criarContaEmpresa(
          username!, email!, senha!, telefone!, cnpj!, razaoSocial!);
      usuarios.add(novoUsuarioEmpresa);
      print('Conta de Empresa criada com sucesso!');
      break;

    default:
      print('Opção inválida. Tente novamente.');
      break;
  }
}
