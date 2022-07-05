import HttpClient from 'api/HttpClient'

abstract class BaseService<T> {
  protected abstract URL: string;

  public async index(params = {}) {
    const {data} = await HttpClient.get(this.URL, {params})
    return data
  }

  public async create(element: T) {
    try {
      const {data} = await HttpClient.post(this.URL, element)
      return data
    } catch (error: any) {
      const errors = error?.response?.data?.errors

      if (errors) { return {errors} }

      throw error
    }
  }
}

export default BaseService
