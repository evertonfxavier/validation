const validarEmail = (email) => {
  const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return regex.test(email);
};

const validarSenha = (senha) => {
  const regex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/;
  return regex.test(senha);
};

const validarNome = (nome) => {
  return typeof nome === "string" && nome.trim().length > 0;
};

const validarTelefone = (telefone) => {
  const regex = /^\(?\d{2}\)?[\s-]?\d{4,5}-?\d{4}$/;
  return regex.test(telefone);
};

const validarCampoObrigatorio = (valor) => {
  return (
    valor !== undefined && valor !== null && valor.toString().trim() !== ""
  );
};
