import axios from "axios";

const LoginApi = async (username: string, password: string) => {
  return await axios.post<{ access_token: string }>("/api/auth/login", {
    username,
    password,
  });
};

export default LoginApi;
