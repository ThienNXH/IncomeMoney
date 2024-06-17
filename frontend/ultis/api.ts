import axios from 'axios';

const api = axios.create({
  baseURL: 'http://localhost:7113',
});

export default api;
