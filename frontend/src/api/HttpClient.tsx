import axios from 'axios'
import variables from 'variables'
import qs from 'qs'

const httpClient = axios.create({
  baseURL: variables.baseURL
})

httpClient.interceptors.request.use(config => {
  config.paramsSerializer = params => {
    return qs.stringify(params, {
      arrayFormat: 'brackets',
      encode: false
    });
  };

  return config;
});

export default httpClient
