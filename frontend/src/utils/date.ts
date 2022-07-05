function getCurrentDate(): Date {
  return new Date()
}

function substractDays(initialDate: Date, days: number): Date {
  const date = new Date(initialDate.getTime())

  date.setDate(date.getDate() - days)

  return date
}

function formatDateBasic(date: Date): string {
  return date.toISOString().substring(0,16)
}

export {
  getCurrentDate,
  substractDays,
  formatDateBasic
}
